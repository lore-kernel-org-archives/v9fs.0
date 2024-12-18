Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A61E155C87
	for <v9fs@lists.linux.dev>; Wed, 18 Dec 2024 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734552278; cv=none; b=pkP65JvMZcJ4WG/0ZkD2BRBO3ufCjVl0RjwlGcIvbKsrqHHDjtclBgArgdc75kwtpVyA+fOTvRse/RsuSq6iS2Mkhfc4czNqhwLul7lZMjDC6Irfdodf0RsgT1qJ9Qs+B/zoaRnAbGvk+87cSNfQQBBXy07VuMMUrC00pdQYYlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734552278; c=relaxed/simple;
	bh=hK70YHuHKKoHw5fr/iBGZ8oNq1XDa9gqt41IIJRQ41c=;
	h=To:From:Subject:MIME-Version:Content-Type:Date:Message-ID; b=fRaxBLqOY940pkFWpweRp2qhWrLPlvHzKU+bhT7OxgBMteI/Ybfnii+Jz0k3BxLA6P4uq5BtsclMC86OJ23rwseG/VgdSbfrsto2oCO7ZpOanDq8fJycFmVe3/q9jTcaEgrRFfQx694Qy2oRFNbXGtrK0Vxtr2i3bANxM3DYOGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b=W8kEND0l; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b="W8kEND0l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=Message-ID:Date:Content-Type:
	MIME-Version:Subject:Reply-To:From:To:Sender:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JvN0HFTrhRuNVeAJgK1y98EGJuaEztGU8Ks5PZ/zKLo=; t=1734552276; x=1735416276; 
	b=W8kEND0luo0LBjaCVgvyDz14CnOG7/r/0wTKOVwVJohxPHBfxoor1StvG1IdRgfB2EOC8V2fuXh
	lh3HeARbwVc1Vhfvq4Cj3xmcWIBggk0xnh8i5rvxNc9J3ehXmpMHwGLhmKjCj0J+M+QHwA1RENn/F
	udnCbDOUQECJCguIrVCJ1v0URNzmWO44oUlqNjWw/ghWfLEYZjzgiSCW61BbAGUDy5i+gLsadAGZ/
	bbRaE0O+nl8R6OBPBW6mXC/q/4DWPEBpJGOPwRpERMMNSr3xvHqYm522vBnioCPRbvkJ1H2uwVksy
	m18FcLJXS3YyRTRHpkCdT6Ub6+SNUGiXPjHA==;
Received: from [73.149.18.137] (helo=crash.local)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <rtm@csail.mit.edu>)
	id 1tO0HQ-00A3kH-HA;
	Wed, 18 Dec 2024 15:04:24 -0500
Received: from localhost (localhost [127.0.0.1])
	by crash.local (Postfix) with ESMTP id 0CA3C183CACD;
	Wed, 18 Dec 2024 15:04:24 -0500 (EST)
To: Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev
From: rtm@csail.mit.edu
Reply-To: rtm@csail.mit.edu
Subject: 9p server can confuse client about FIFO vs regular file -> crash
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Date: Wed, 18 Dec 2024 15:04:24 -0500
Message-ID: <67125.1734552264@localhost>

--=-=-=
Content-Type: text/plain

If a 9p client asks to creat() a new file, and the server does so but
unexpectedly claims in answer to the ensuing Tgetattr that the new
file is a FIFO, then the client's file->f_op is &pipefifo_fops, but
file->private_data points to a p9_fid, not a pipe_inode_info. This
causes trouble when pipe_*() try to use file->private_data.

Ordinarily, d_dentry_open() both sets file->f_op and calls
file->f_op->open(), which sets file->private_data consistently with
file->f_op.

But v9fs_vfs_atomic_open_dotl() calls finish_open() with the open
argument set to generic_file_open, which causes d_dentry_open() to *not*
call file->f_op->open(). And v9fs_vfs_atomic_open_dotl() sets
file->private_data to a p9_fid.

A summary:

v9fs_vfs_atomic_open_dotl()
  v9fs_get_new_inode_from_fid()
    v9fs_inode_from_fid_dotl()
      v9fs_qid_iget_dotl()
        v9fs_init_inode()
          case S_IFIFO:
          init_special_inode()
            } else if (S_ISFIFO(mode))
              inode->i_fop = &pipefifo_fops;
  finish_open(..., open=generic_file_open)
    do_dentry_open(..., open=generic_file_open)
      f->f_op = fops_get(inode->i_fop)
      if (!open)
              open = f->f_op->open;
      if (open) {
              error = open(inode, f); // calls generic_file_open, not pipe_open
  file->private_data = ofid

I've attached a demo, which first gets a mutex error because
pipe_write() thinks file->private_data ought to start with a mutex,
and then a page fault.

# uname -a
Linux xxx 6.13.0-rc3-00017-gf44d154d6e3d #13 SMP Tue Dec 17 07:03:22 EST 2024 x86_64 x86_64 x86_64 GNU/Linux
# cc 9p6c.c
# ./a.out
...
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 3 PID: 1551 at kernel/locking/mutex.c:564 __mutex_lock.constprop.0
+0x6b9/0x990
CPU: 3 UID: 0 PID: 1551 Comm: a.out Not tainted 6.13.0-rc3-00017-gf44d154d6e3d #
13
Hardware name: FreeBSD BHYVE/BHYVE, BIOS 14.0 10/17/2021
RIP: 0010:__mutex_lock.constprop.0+0x6b9/0x990
Code: ff 85 c0 0f 84 cc f9 ff ff 8b 15 c2 5a 5d 01 85 d2 0f 85 be f9 ff ff 48 c7
 c6 4d 5e c7 82 48 c7 c7 8e e1 c6 82 e8 e7 7b d6 fe <0f> 0b e9 a4 f9 ff ff 0f 0b
 e9 d1 fa ff ff 48 8b 03 a8 08 0f 85 fa
RSP: 0018:ffffc90001f03d50 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000027
RDX: ffff88842dadc848 RSI: 0000000000000001 RDI: ffff88842dadc840
RBP: ffffc90001f03de0 R08: 00000000ffffefff R09: 0000000000000001
R10: 00000000ffffefff R11: ffffffff8365b2c0 R12: ffff8881021b5a80
R13: ffff888113d33280 R14: ffffc90001f03f10 R15: 0000000000000000
FS:  00007f294d1df740(0000) GS:ffff88842dac0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000560867bb0008 CR3: 0000000109c66004 CR4: 00000000003706f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? __warn+0x7f/0x130
 ? __mutex_lock.constprop.0+0x6b9/0x990
 ? report_bug+0x16e/0x1a0
 ? prb_read_valid+0x16/0x20
 ? handle_bug+0x53/0x90
 ? exc_invalid_op+0x17/0x70
 ? asm_exc_invalid_op+0x1a/0x20
 ? __mutex_lock.constprop.0+0x6b9/0x990
 ? do_sys_openat2+0x78/0xc0
 ? set_track_prepare+0x3b/0x60
 ? do_sys_openat2+0x78/0xc0
 ? check_bytes_and_report.isra.0+0x48/0x120
 pipe_write+0x48/0x660
 ? free_to_partial_list+0x116/0x5e0
 ? do_sys_openat2+0x78/0xc0
 vfs_write+0x23d/0x400
 ksys_write+0x67/0xe0
 do_syscall_64+0x3f/0xd0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f294d2fe574
Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d d5 ea 0e 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
RSP: 002b:00007fffb311e078 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fffb311ea58 RCX: 00007f294d2fe574
RDX: 0000000000000001 RSI: 0000560867bad0a6 RDI: 0000000000000003
RBP: 00007fffb311e930 R08: 00007f294d3e5b20 R09: 0000000000000410
R10: 0000000000000001 R11: 0000000000000202 R12: 0000000000000001
R13: 0000000000000000 R14: 0000560867baece8 R15: 00007f294d440000
 </TASK>
---[ end trace 0000000000000000 ]---
BUG: unable to handle page fault for address: 000000000002fcc0
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 0 P4D 0
Oops: Oops: 0002 [#1] SMP DEBUG_PAGEALLOC PTI
CPU: 3 UID: 0 PID: 1551 Comm: a.out Tainted: G        W          6.13.0-rc3-00017-gf44d154d6e3d #13
Tainted: [W]=WARN
Hardware name: FreeBSD BHYVE/BHYVE, BIOS 14.0 10/17/2021
RIP: 0010:osq_lock+0x57/0xf0
Code: 00 00 00 00 00 89 42 14 87 07 85 c0 0f 84 98 00 00 00 83 e8 01 48 c7 c1 c0 fc 02 00 48 98 48 03 0c c5 c0 49 cf 82 48 89 4a 08 <48> 89 11 8b 42 10 85 c0 75 76 65 48 8b 3d 17 e6 f2 7e eb 09 f3 90
RSP: 0018:ffffc90001f03d48 EFLAGS: 00010206
RAX: fffffffffffffffe RBX: ffff888107269940 RCX: 000000000002fcc0
RDX: ffff88842daefcc0 RSI: ffff888113d332a0 RDI: ffff888113d332a0
RBP: ffffc90001f03de0 R08: 00000000ffffefff R09: 0000000000000001
R10: 00000000ffffefff R11: ffffffff8365b2c0 R12: ffff88810cc6ba00
R13: ffff888113d33280 R14: ffff888113d332a0 R15: 0000000000000000
FS:  00007f294d1df740(0000) GS:ffff88842dac0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000002fcc0 CR3: 0000000109c66004 CR4: 00000000003706f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? __die+0x1e/0x60
 ? page_fault_oops+0x157/0x450
 ? __warn+0xa5/0x130
 ? __mutex_lock.constprop.0+0x6b9/0x990
 ? nbcon_get_cpu_emergency_nesting+0x5/0x30
 ? exc_page_fault+0x66/0x140
 ? asm_exc_page_fault+0x26/0x30
 ? osq_lock+0x57/0xf0
 __mutex_lock.constprop.0+0x2b2/0x990
 ? do_sys_openat2+0x78/0xc0
 ? set_track_prepare+0x3b/0x60
 ? do_sys_openat2+0x78/0xc0
 ? check_bytes_and_report.isra.0+0x48/0x120
 pipe_write+0x48/0x660
 ? free_to_partial_list+0x116/0x5e0
 ? do_sys_openat2+0x78/0xc0
 vfs_write+0x23d/0x400
 ksys_write+0x67/0xe0
 do_syscall_64+0x3f/0xd0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f294d2fe574
...
Kernel panic - not syncing: Fatal exception
Kernel Offset: disabled
---[ end Kernel panic - not syncing: Fatal exception ]---

Robert Morris
rtm@mit.edu


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=9p6c.c
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHVuaXN0ZC5o
PgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxmY250bC5oPgojaW5jbHVkZSA8ZXJybm8u
aD4KI2luY2x1ZGUgPHRpbWUuaD4KI2luY2x1ZGUgPHN5cy9zdGF0Lmg+CiNpbmNsdWRlIDxzeXMv
c29ja2V0Lmg+CiNpbmNsdWRlIDxzeXMvaW9jdGwuaD4KI2luY2x1ZGUgPG5ldGluZXQvaW4uaD4K
I2luY2x1ZGUgPHN5cy93YWl0Lmg+CiNpbmNsdWRlIDxzeXMvcmVzb3VyY2UuaD4KCmludCByZWFk
bihpbnQgZmQsIGNoYXIgKmJ1ZiwgaW50IG4pIHsKICBpbnQgb3JpZyA9IG47CiAgd2hpbGUobiA+
IDApewogICAgaW50IGNjID0gcmVhZChmZCwgYnVmLCBuKTsKICAgIGlmKGNjIDw9IDApIHsgcGVy
cm9yKCJyZWFkIik7IHJldHVybiAtMTsgfQogICAgbiAtPSBjYzsKICAgIGJ1ZiArPSBjYzsKICB9
CiAgcmV0dXJuIG9yaWc7Cn0KCmNoYXIgKgpnZXRzdHIodW5zaWduZWQgY2hhciAqcCkKewogIHVu
c2lnbmVkIGludCBuID0gKih1bnNpZ25lZCBzaG9ydCAqKXA7CiAgY2hhciAqYnVmID0gbWFsbG9j
KG4rMSk7CiAgbWVtY3B5KGJ1ZiwgcCsyLCBuKTsKICBidWZbbl0gPSAnXDAnOwogIHJldHVybiBi
dWY7Cn0KCmludAptYWluKCl7CiAgc3RydWN0IHJsaW1pdCByOwogIHIucmxpbV9jdXIgPSByLnJs
aW1fbWF4ID0gMDsKICBzZXRybGltaXQoUkxJTUlUX0NPUkUsICZyKTsKCiAgaW50IHMgPSBzb2Nr
ZXQoQUZfSU5FVCwgU09DS19TVFJFQU0sIDApOwogIHsgaW50IHllcyA9IDE7CiAgICBzZXRzb2Nr
b3B0KHMsIFNPTF9TT0NLRVQsIFNPX1JFVVNFQUREUiwgJnllcywgc2l6ZW9mKHllcykpOwogIH0K
ICBzdHJ1Y3Qgc29ja2FkZHJfaW4gc2luOwogIG1lbXNldCgmc2luLCAwLCBzaXplb2Yoc2luKSk7
CiAgc2luLnNpbl9mYW1pbHkgPSBBRl9JTkVUOwogIHNpbi5zaW5fcG9ydCA9IGh0b25zKDU2NCk7
CiAgaWYoYmluZChzLCAoc3RydWN0IHNvY2thZGRyICopJnNpbiwgc2l6ZW9mKHNpbikpIDwgMCl7
CiAgICBwZXJyb3IoImJpbmQiKTsgZXhpdCgxKTsKICB9CiAgbGlzdGVuKHMsIDEwKTsKICBzeW5j
KCk7IHNsZWVwKDEpOwoKICBpZihmb3JrKCkgPT0gMCl7CiAgICBjbG9zZShzKTsKICAgIC8vIC1v
IC4uLixkZWJ1Zz0weDEwZgogICAgaWYoc3lzdGVtKCJlY2hvIC1uIG1vdW50OiA7IG1vdW50IC10
IDlwIC1vIG5vZGV2bWFwLHRyYW5zPXRjcCxjYWNoZT1ub25lLGFjY2Vzcz1hbnksZGVidWc9MHgw
IDEyNy4wLjAuMSAvbW50IikgPT0gMCl7CgogICAgICBzeXN0ZW0oIm1vdW50IHwgZ3JlcCAvbW50
Iik7CiAgICAgIAogICAgICBwcmludGYoIm9wZW4gL21udC9iOlxuIik7CiAgICAgIGludCBmZCA9
IGNyZWF0KCIvbW50L2IiLCAwNzc3KTsKICAgICAgaWYoZmQgPCAwKSBwZXJyb3IoImNyZWF0Iik7
CiAgICAgIHdyaXRlKGZkLCAieCIsIDEpOwogICAgICBjaGFyIGp1bmtbMV07CiAgICAgIHJlYWQo
ZmQsIGp1bmssIDEpOwogICAgICBwcmludGYoImNsb3NlIC9tbnQvYjpcbiIpOwogICAgICBjbG9z
ZShmZCk7CgogICAgICBzeXN0ZW0oImVjaG8gLW4gdW1vdW50OiA7IHVtb3VudCAtZiAvbW50Iik7
CiAgICB9CiAgICBleGl0KDApOwogIH0KCiAgaW50IHNwaWQgPSBmb3JrKCk7CiAgaWYoc3BpZCA9
PSAwKXsKICAgIHNvY2tsZW5fdCBzaW5sZW4gPSBzaXplb2Yoc2luKTsKICAgIGludCBzMSA9IGFj
Y2VwdChzLCAoc3RydWN0IHNvY2thZGRyICopICZzaW4sICZzaW5sZW4pOwogICAgaWYoczEgPCAw
KSB7IHBlcnJvcigiYWNjZXB0Iik7IGV4aXQoMSk7IH0KICAgIGNsb3NlKHMpOwogIAogICAgaW50
IG9wbm8gPSAwOwogICAgd2hpbGUoMSl7CiAgICAgIGNoYXIgaWJ1ZlsxMDI0XTsKICAgICAgaWYo
cmVhZG4oczEsIGlidWYsIDQpIDwgMCkgYnJlYWs7CiAgICAgIGludCBpbGVuID0gKihpbnQqKShp
YnVmKzApOwogICAgICBpZihyZWFkbihzMSwgaWJ1Zis0LCBpbGVuIC0gNCkgPCAwKSBicmVhazsK
CiAgICAgIHByaW50ZigiJWQ6ICIsIG9wbm8pOwogICAgICBmZmx1c2goc3Rkb3V0KTsKCiAgICAg
IGNoYXIgb2J1ZltzaXplb2YoaWJ1ZildOwogICAgICBtZW1zZXQob2J1ZiwgMHhmZiwgc2l6ZW9m
KG9idWYpKTsKICAgICAgKihpbnQqKShvYnVmKzApID0gaWxlbjsgLy8gbGVuZ3RoCiAgICAgIGlm
KGlidWZbNF0gPT0gMTAwKXsgLy8gVHZlcnNpb24KICAgICAgICBwcmludGYoInZlcnNpb24gJWQg
JXNcbiIsICooaW50KikoaWJ1Zis3KSwgZ2V0c3RyKGlidWYrMTEpKTsKICAgICAgICBtZW1jcHko
b2J1ZiwgaWJ1ZiwgaWxlbik7CiAgICAgIH0gZWxzZSBpZihpYnVmWzRdID09IDI0KXsgLy8gVGdl
dGF0dHIgKGRpZmZlcmVudCBmcm9tIFRzdGF0ISkKICAgICAgICBwcmludGYoImdldGF0dHJcbiIp
OwogICAgICAgIC8vIGh0dHBzOi8vZ2l0aHViLmNvbS9jaGFvcy9kaW9kL2Jsb2IvbWFzdGVyL3By
b3RvY29sLm1kCiAgICAgICAgaW50IHN6ID0gMTYxOwogICAgICAgICooaW50Kikob2J1ZiswKSA9
IHN6ICsgNzsKICAgICAgICAqKGludCopKG9idWYrMzIpID0gMDsgLy8gdWlkCiAgICAgICAgKihp
bnQqKShvYnVmKzM2KSA9IDA7IC8vIGdpZAogICAgICAgIGlmKG9wbm8gPT0gNyl7CiAgICAgICAg
ICAvLyooaW50Kikob2J1ZisyOCkgPSAwMTAwNzc3OyAvLyBTX0lGUkVHLCByd3hyd3hyd3gKICAg
ICAgICAgICooaW50Kikob2J1ZisyOCkgPSAwMTA3Nzc7IC8vIFNfSUZJRk8sIHJ3eHJ3eHJ3eAog
ICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAqKGludCopKG9idWYrMjgpID0gMDA0MDc3NzsgLy8g
U19JRkRJUiwgcnd4cnd4cnd4CiAgICAgICAgfQogICAgICB9IGVsc2UgaWYoaWJ1Zls0XSA9PSAx
MTApeyAvLyBUd2FsawogICAgICAgIGludCBud3FpZCA9ICooc2hvcnQqKShpYnVmKzE1KTsKICAg
ICAgICBwcmludGYoIndhbGsgJWQgJXNcbiIsIG53cWlkLCBud3FpZD9nZXRzdHIoaWJ1ZisxNyk6
Ii0iKTsKICAgICAgICBpZihvcG5vID09IDMpewogICAgICAgICAgLy8gZXJyb3IuLi4KICAgICAg
ICAgIGlidWZbNF0gPSAxMDY7IC8vIFRlcnJvcgogICAgICAgICAgKihpbnQqKShvYnVmKzApID0g
MTE7CiAgICAgICAgICAqKGludCopKG9idWYrNykgPSBFTk9FTlQ7CiAgICAgICAgfSBlbHNlIHsK
ICAgICAgICAgICooc2hvcnQqKShvYnVmKzcpID0gbndxaWQ7CiAgICAgICAgICAqKGludCopKG9i
dWYrMCkgPSA5ICsgbndxaWQqMTM7CiAgICAgICAgICBpZihvcG5vID09IDI0KXsKICAgICAgICAg
ICAgKihjaGFyKikob2J1ZisyMSkgPSAxOwogICAgICAgICAgfQogICAgICAgIH0KICAgICAgfSBl
bHNlIGlmKGlidWZbNF0gPT0gMTA0KXsgLy8gVGF0dGFjaAogICAgICAgIHByaW50ZigiYXR0YWNo
XG4iKTsKICAgICAgICAqKGludCopKG9idWYrMCkgPSAyMDsKICAgICAgfSBlbHNlIGlmKGlidWZb
NF0gPT0gMTIwKXsgLy8gVGNsdW5rCiAgICAgICAgcHJpbnRmKCJjbHVua1xuIik7CiAgICAgICAg
KihpbnQqKShvYnVmKzApID0gNzsKICAgICAgfSBlbHNlIGlmKGlidWZbNF0gPT0gMzApeyAvLyBU
eGF0dHJ3YWxrCiAgICAgICAgcHJpbnRmKCJ4YXR0cndhbGtcbiIpOwogICAgICAgICooaW50Kiko
b2J1ZiswKSA9IDE1OwogICAgICAgICoobG9uZyopKG9idWYrNykgPSAyOyAvLyBzaXplCiAgICAg
IH0gZWxzZSBpZihpYnVmWzRdID09IDExNil7IC8vIFRyZWFkCiAgICAgICAgdW5zaWduZWQgbG9u
ZyBvZmZzZXQgPSAqKGxvbmcqKShpYnVmKzExKTsKICAgICAgICB1bnNpZ25lZCBpbnQgY291bnQg
PSAqKGludCopKGlidWYrMTkpOwogICAgICAgIHByaW50ZigicmVhZCAlbGQgJWRcbiIsIG9mZnNl
dCwgY291bnQpOyBmZmx1c2goc3Rkb3V0KTsKICAgICAgICBpbnQgbiA9IDA7CiAgICAgICAgaWYo
b2Zmc2V0ID09IDAgJiYgY291bnQgPiAyKXsKICAgICAgICAgIHVuc2lnbmVkIGNoYXIgKnAgPSBv
YnVmKzExOwogICAgICAgICAgdW5zaWduZWQgY2hhciAqcDAgPSBwOwoKICAgICAgICAgIHAgKz0g
MjsgLy8gc2l6ZTsKICAgICAgICAgIHAgKz0gMjsgLy8gdHlwZQogICAgICAgICAgcCArPSA0OyAv
LyBkZXYKICAgICAgICAgIHAgKz0gMTsgLy8gcWlkLnR5cGUKICAgICAgICAgIHAgKz0gNDsgLy8g
cWlkLnZlcnMKICAgICAgICAgIHAgKz0gODsgLy8gcWlkLnBhdGgKICAgICAgICAgIHAgKz0gNDsg
Ly8gcGVybWlzc2lvbnMKICAgICAgICAgIHAgKz0gNDsgLy8gYXRpbWUKICAgICAgICAgIHAgKz0g
NDsgLy8gbXRpbWUKICAgICAgICAgIHAgKz0gODsgLy8gbGVuZ3RoCiAgICAgICAgICAqKHNob3J0
KilwID0gMTsgLy8gbmFtZSBsZW5ndGgKICAgICAgICAgIHArKzsKICAgICAgICAgICpwKysgPSAn
eCc7CiAgICAgICAgICAqKHNob3J0KilwID0gMTsgLy8gb3duZXIgbmFtZSBsZW5ndGgKICAgICAg
ICAgICpwKysgPSAneCc7CiAgICAgICAgICAqKHNob3J0KilwID0gMTsgLy8gZ3JvdXAgbmFtZSBs
ZW5ndGgKICAgICAgICAgICpwKysgPSAneCc7CiAgICAgICAgICAqKHNob3J0KilwID0gMTsgLy8g
bGFzdCBtb2RpZnkgdXNlciBuYW1lIGxlbmd0aAogICAgICAgICAgKnArKyA9ICd4JzsKICAgICAg
ICAgICAgCiAgICAgICAgICBuID0gcCAtIHAwOwogICAgICAgICAgcHJpbnRmKCIgPj4+IG49JWQg
PDw8ICIsIG4pOyBmZmx1c2goc3Rkb3V0KTsKICAgICAgICAgICooc2hvcnQqKShwMCkgPSBuOwog
ICAgICAgIH0KICAgICAgICAqKGludCopKG9idWYrMCkgPSBuICsgMTE7CiAgICAgICAgKihpbnQq
KShvYnVmKzcpID0gbjsKICAgICAgfSBlbHNlIGlmKGlidWZbNF0gPT0gMTIpeyAvLyBUbG9wZW4K
ICAgICAgICBwcmludGYoImxvcGVuXG4iKTsKICAgICAgICAqKGludCopKG9idWYrMCkgPSAyNDsK
ICAgICAgfSBlbHNlIGlmKGlidWZbNF0gPT0gNDApeyAvLyBUcmVhZGRpcgogICAgICAgIHByaW50
ZigicmVhZGRpclxuIik7CiAgICAgICAgLy8gZWFjaCBkaXJlbnQgaXMgMjUgYnl0ZXMKICAgICAg
ICB1bnNpZ25lZCBsb25nIG9mZnNldCA9ICoobG9uZyopKGlidWYrMTEpOwogICAgICAgIHVuc2ln
bmVkIGludCBjb3VudCA9ICooaW50KikoaWJ1ZisxOSk7CiAgICAgICAgaW50IG4gPSAwOwogICAg
ICAgIGlmKG9mZnNldCA9PSAwKXsKICAgICAgICAgIG4gPSAxOwogICAgICAgICAgdW5zaWduZWQg
Y2hhciAqcDAgPSBvYnVmICsgMTE7CiAgICAgICAgICB1bnNpZ25lZCBjaGFyICpwID0gcDA7CiAg
ICAgICAgICBwICs9IDEzOyAvLyBxaWQKICAgICAgICAgIHAgKz0gODsgLy8gb2Zmc2V0CiAgICAg
ICAgICBwICs9IDE7IC8vIHR5cGUKICAgICAgICAgICooc2hvcnQqKXAgPSAxOwogICAgICAgICAg
cCArPSAyOwogICAgICAgICAgKnArKyA9ICd4JzsKICAgICAgICB9CiAgICAgICAgKihpbnQqKShv
YnVmKzApID0gMTEgKyBuKjI1OwogICAgICB9IGVsc2UgaWYoaWJ1Zls0XSA9PSA4KXsgLy8gVHN0
YXRmcwogICAgICAgIHByaW50Zigic3RhdGZzXG4iKTsKICAgICAgICAqKGludCopKG9idWYrMCkg
PSA2NzsKICAgICAgfSBlbHNlIGlmKGlidWZbNF0gPT0gNzIpeyAvLyBUbWtkaXIKICAgICAgICBw
cmludGYoIm1rZGlyICVzXG4iLCBnZXRzdHIoaWJ1ZiArIDExKSk7CiAgICAgICAgKihpbnQqKShv
YnVmKzApID0gMjA7CiAgICAgIH0gZWxzZSBpZihpYnVmWzRdID09IDc0KXsgLy8gVHJlbmFtZWF0
CiAgICAgICAgcHJpbnRmKCJyZW5hbWVhdCAlc1xuIiwgZ2V0c3RyKGlidWYgKyAxMSkpOwogICAg
ICAgICooaW50Kikob2J1ZiswKSA9IDc7CiAgICAgIH0gZWxzZSBpZihpYnVmWzRdID09IDE0KXsg
Ly8gVGxjcmVhdGUKICAgICAgICBwcmludGYoImxjcmVhdGUgJXNcbiIsIGdldHN0cihpYnVmICsg
MTEpKTsKICAgICAgICAqKGludCopKG9idWYrMCkgPSAyNDsKICAgICAgfSBlbHNlIGlmKGlidWZb
NF0gPT0gMjYpeyAvLyBUc2V0YXR0cgogICAgICAgIHByaW50Zigic2V0YXR0ciAlc1xuIiwgZ2V0
c3RyKGlidWYgKyAxMSkpOwogICAgICAgICooaW50Kikob2J1ZiswKSA9IDc7CiAgICAgIH0gZWxz
ZSBpZihpYnVmWzRdID09IDc2KXsgLy8gVHVubGlua2F0CiAgICAgICAgcHJpbnRmKCJ1bmxpbmth
dCAlc1xuIiwgZ2V0c3RyKGlidWYgKyAxMSkpOwogICAgICAgICooaW50Kikob2J1ZiswKSA9IDc7
CiAgICAgIH0gZWxzZSB7CiAgICAgICAgcHJpbnRmKCIlZCA/Pz9cbiIsIGlidWZbNF0gJiAweGZm
KTsKICAgICAgfQogICAgICBmZmx1c2goc3Rkb3V0KTsKICAgICAgb2J1Zls0XSA9IGlidWZbNF0g
KyAxOyAvLyBjb252ZXJ0IFR4eHggdG8gUnh4eAogICAgICAqKHNob3J0Kikob2J1Zis1KSA9ICoo
c2hvcnQqKShpYnVmKzUpOyAvLyB0YWcKCiAgICAgIGlmKG9idWZbNF0gPT0gMjUpewogICAgICAg
IHByaW50ZigiUmdldGF0dHIgIyVkOiAiLCBvcG5vKTsKICAgICAgICAvLyBodHRwczovL2dpdGh1
Yi5jb20vY2hhb3MvZGlvZC9ibG9iL21hc3Rlci9wcm90b2NvbC5tZAogICAgICAgIHByaW50Zigi
b3AgJWQgIiwgb2J1Zls0XSk7CiAgICAgICAgcHJpbnRmKCJtb2RlIDAlbyAiLCAqKHVuc2lnbmVk
IGludCAqKShvYnVmKzI4KSk7CiAgICAgICAgcHJpbnRmKCJcbiIpOwogICAgICB9CgogICAgICBp
Zih3cml0ZShzMSwgb2J1ZiwgKihpbnQqKShvYnVmKzApKTw9MCkgcGVycm9yKCJ3cml0ZSIpOwoK
ICAgICAgb3BubyArPSAxOwogICAgfQoKICAgIGV4aXQoMCk7CiAgfQogIGNsb3NlKHMpOwoKICB0
aW1lX3QgdDAgPSB0aW1lKDApOwogIHdoaWxlKDEpewogICAgaW50IHN0OwogICAgaW50IHJldCA9
IHdhaXRwaWQoLTEsICZzdCwgV05PSEFORyk7CiAgICBpZihyZXQgPiAwKQogICAgICBicmVhazsK
ICAgIHVzbGVlcCgyMDAwMDApOwogICAgdGltZV90IHQxID0gdGltZSgwKTsKICAgIGlmKHQxIC0g
dDAgPj0gMTApewogICAgICBwcmludGYoIjlwbmV3OiB0aW1lb3V0XG4iKTsKICAgICAgYnJlYWs7
CiAgICB9CiAgfQp9Cg==
--=-=-=--
