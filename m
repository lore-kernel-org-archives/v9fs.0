Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878DE34D3A4
	for <v9fs@lists.linux.dev>; Sun,  2 Nov 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762115129; cv=none; b=WCoa7Mm+n9TxwcH5e29EwECw9e9+FLLiQzQgCOmlGAVDycEAJLyn2al1LZcPe2Oa4uTywRPkNgkHBIP7jzfQhsQtvegbj8MlMd1OYNino0jMD05oEhPqO0s/CN88t8roeCDn8/A6rhrCqNsvwl00hY4ar8rbmEKLE1s915oefV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762115129; c=relaxed/simple;
	bh=KXLL/3NJYFu1aZuiUb0UDcPYsM1VDkKbCAUS8wV+xHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q8sd1sZc0OMsbJA+ZDlH4H8fELAN1TglK8n8/QuDVqpQZcpM+pGpwGp3DGi16X+jcDoTiBgzpPuGyTVE2bKfWFp3QxrPuPzOXu5ZAKImILCWDVqto9KtquHD7FFOS32eur6jlW+Rdwts5wi038vp0306XHEZQmVjZIXXVxWNPh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=HIh5QDb0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x/RCHS9q; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="HIh5QDb0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x/RCHS9q"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 93CFE14000B8;
	Sun,  2 Nov 2025 15:25:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 02 Nov 2025 15:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1762115125; x=1762201525; bh=TLyd2y7k+idLAsBuTl9V/
	RCJ/cY9BGN5lcpR1LBKpgQ=; b=HIh5QDb0WIFR1J4MuTgzR6820NDBfLOzKZcvm
	Z29xNRWIyPT00f07uZiurRk0zTU/Qy0A5Q3Nx2b354Fn4+rRogzz4m1m7ZYKpUSM
	nPKPqj1odqWhQb9Wvr8z/u211ZXutuQcD4SaYCpCLzH8JgkMEDfPxqwiIG4Qi9Sh
	FS8g0e7LvZxuG5bA1USQL66N41hoq2Kblez6iy3OTndr7+C+icFMwBlaRNh9jNGN
	d5VxySihmS9hkLHnL05md27T/EYBAIGfs9wuHQPCeiJ3JgjJ7kPiXj0I30YXbJ5U
	CvKJCpYYw45uTfLL2htpHkCJBalpI2fIIl6p6caEscxxXfwQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762115125; x=1762201525; bh=TLyd2y7k+idLAsBuTl9V/RCJ/cY9BGN5lcp
	R1LBKpgQ=; b=x/RCHS9qOkAxZs37if10bWEMXqvinT+xLrS+ywHnlsqIxqVaPX0
	8ByHhUiT1os3QQJxw9u5wKfG1kUcD5AB9YkdZP9kmUIq7THsGWpXCP0pIC9Fbf/q
	VWU1dSBmdBX+55LzH2fONraxu+OYuEExp6n/yXnFy92BlWF72zGmQW4uSh277g3I
	WqRBZDAHWnRixxiuidP+/Tu1dadvQ6xdqbcwrx9gvege1koU6l3JGZawxIMWdAo+
	U2iop1Vh2wbzLHTyJN3JsoD69VRXCSkez5o9SLscpZueLFZQIAUVHKXHAnVn3CMV
	r4Wy/O3b2G5ilP9xY2jwFWVqpE3YNsPmkpg==
X-ME-Sender: <xms:M74HaZptNF5tok_B-mhW3fS2gVYjAlRZuSLY8ze8TVQ9ctjmtb4Jyg>
    <xme:M74HafVHNMTR2Ws65rDwqQG3ipU-01Ct0IhgA2Q0cafNO1yoAB_oyGvCCNCZmJRFT
    f4fUlHJg4PYDMYJupsMYLwXxEyRanxn1Y8ZcbLCa2qbeHm2km20EA>
X-ME-Received: <xmr:M74HaQAciJcrhNC3Rxl-peUKk0JyeqV3draonu4cQCexbHWN7pel2dK2OFBbt19U4MbsvseToDQhg7AqfJvKfkcBts9MRpzEu172NywT7IoIxqZkwCU69Zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeivddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfhinhhgmhgrohcu
    hggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeejvedtke
    fhveetjeekleegleeiheeuueetleeftedvieffieevgfekieeiffevgeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdroh
    hrghdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    rghsmhgruggvuhhssegtohguvgifrhgvtghkrdhorhhgpdhrtghpthhtoheplhhinhhugi
    gpohhsshestghruhguvggshihtvgdrtghomhdprhgtphhtthhopegvrhhitghvhheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhutghhohesihhonhhkohhvrdhnvghtpdhrtg
    hpthhtohepmhesmhgrohifthhmrdhorhhgpdhrtghpthhtohepvhelfhhssehlihhsthhs
    rdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:M74Hab1bCYLCkpBVezLD22B-2rwo55ERviGJ_Om8xtnlfGOqDgqoFA>
    <xmx:M74Haa2sGaWzmN1bDWMMg_qKnbpRHVWRiS_GPNfKLQJjdMkRbc1q2Q>
    <xmx:M74HaYASviEJpIKLbN1AmZDcEFEcHFzhQYEm2oNIWV8Vc0lYgFGo5w>
    <xmx:M74HaR5XlT6_wEi4hNmFojIdIZKKRonakX2LdLSZPkVZbilXlSGULw>
    <xmx:Nb4Had5xo9V0StHRiTQnkCRo_WjLZGxSJFULJ488u94YchUl2HBSD8Ez>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 15:25:22 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>
Cc: Tingmao Wang <m@maowtm.org>,
	v9fs@lists.linux.dev
Subject: [PATCH 0/1] fs/9p: Do not open remote file with APPEND mode when writeback cache is used
Date: Sun,  2 Nov 2025 20:24:38 +0000
Message-ID: <cover.1762115015.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Earlier I noticed that when using cache=mmap mode for my QEMU VM's rootfs,
fish seems to sometimes report corrupted history file.  It turns out that
for some reason, when fish writes the file, a bunch of NUL bytes are being
added to the end.

Some further investigation lead me to conclude that the problem is with
how O_APPEND is handled in v9fs when a caching mode with writeback is used
(e.g. cache=loose or cache=mmap).  Basically, the file is opened with
O_APPEND on the server side as well, in which case writes works fine in
uncached mode, but when the page cache is involved, Linux writes whole
pages (with position for that write pointing to the start of the page),
causing previously written content to be written again (since when the
file is opened with O_APPEND by QEMU, all writes goes to the end
regardless of offset).

Pasted at the end is a program to reproduce the problem.  It will:

1. Open a file with O_APPEND
2. Write "Hello\n", sync, then write "Goodbye\n"
3. At this point the file is corrupted.  It will use drop_caches to make
   the problem immediately observable in the guest when it tries to read
   the data back, even though this is not required - the file on the host
   contains duplicate content as soon as a problematic write is issued.

Here is what happens:

    root@6-18-0-rc3-next-20251031-dev-dirty ~# linux/reproducer-write-then-read /tmp/9p/a
    Try reading /tmp/9p/a from the host now.
    Press Enter to continue...

    We can inspect the content from the host at this point:
    > hexdump -C /tmp/linux-test/a
    00000000  48 65 6c 6c 6f 0a 48 65  6c 6c 6f 0a 47 6f 6f 64  |Hello.Hello.Good|
    00000010  62 79 65 0a                                       |bye.|
    00000014

    The program will also detect this.

Here is the same setup but with some debug logs (I added logging to dump
the content being sent to the host)

    openat(AT_FDCWD, "/tmp/9p/a", O_WRONLY|O_CREAT|O_APPEND, 0644
    [   10.207738][  T197] 9pnet: -- v9fs_vfs_lookup (197): dir: ffff888103228000 dentry: (a) ffff88810042ebc0 flags: 0
    ...
    ) = 3
    write(3, "Hello\n", 6
    [   10.211944][  T197] 9pnet: -- v9fs_file_write_iter (197): fid 2
    [   10.212057][  T197] 9pnet: -- v9fs_file_write_iter (197): (cached)
    )                  = 6
    sync(
    [   10.212550][   T61] 9pnet: -- v9fs_fid_find_inode (61):  inode: ffff88810a128000
    [   10.212794][   T61] 9pnet: (00000061) >>> TWRITE fid 2 offset 0 count 6 (/6)
    [   10.212932][   T61] content to be written: 00000000: 48 65 6c 6c 6f 0a                                Hello.
    [   10.213224][   T61] 9pnet: (00000061) >>> size=29 type: 118 tag: 0
    [   10.213447][   T61] 9pnet: (00000061) <<< size=11 type: 119 tag: 0
    [   10.213565][   T61] 9pnet: (00000061) <<< RWRITE count 6
    [   10.213751][   T61] 9pnet: -- v9fs_write_inode_dotl (61): v9fs_write_inode_dotl: inode ffff88810a128000
    )                                  = 0
    write(3, "Goodbye\n", 8
    [   10.270821][  T197] 9pnet: -- v9fs_file_write_iter (197): fid 2
    [   10.270920][  T197] 9pnet: -- v9fs_file_write_iter (197): (cached)
    )                = 8
    fsync(3
    [   10.271346][  T197] 9pnet: -- v9fs_fid_find_inode (197):  inode: ffff88810a128000
    [   10.271501][  T197] 9pnet: (00000197) >>> TWRITE fid 2 offset 0 count 14 (/14)
    [   10.271610][  T197] content to be written: 00000000: 48 65 6c 6c 6f 0a 47 6f 6f 64 62 79 65 0a        Hello.Goodbye.
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    This causes "Hello\n" to be written again due to the file being opened
    in append mode on the host.

    [   10.271772][  T197] 9pnet: (00000197) >>> size=37 type: 118 tag: 0
    [   10.271933][  T197] 9pnet: (00000197) <<< size=11 type: 119 tag: 0
    [   10.272030][  T197] 9pnet: (00000197) <<< RWRITE count 14
    [   10.272205][  T197] 9pnet: -- v9fs_file_fsync_dotl (197): filp ffff88810952b800 datasync 0
    [   10.272325][  T197] 9pnet: (00000197) >>> TFSYNC fid 2 datasync:0
    [   10.272494][  T197] 9pnet: (00000197) >>> size=15 type: 50 tag: 0
    [   10.272640][  T197] 9pnet: (00000197) <<< size=7 type: 51 tag: 0
    [   10.272733][  T197] 9pnet: (00000197) <<< RFSYNC fid 2
    )                                = 0
    close(3
    [   10.273010][  T197] 9pnet: -- v9fs_dir_release (197): inode: ffff88810a128000 filp: ffff88810952b800 fid: 2
    ...

My understanding is that when we get to v9fs' write_iter, iocb->ki_pos
will, for an O_APPEND file, always point at the end (c.f.
generic_write_checks_count), so technically, except to mitigate guest vs
host write race conditions, we never needed to open the file as O_APPEND
on the server side in the first place, as we always send the correct
offset.

This can also lead to unexpected file lengthing if an fstat is issued
after a write, since we will (first flush the dirty pages, then) refresh
the i_size from the server.  This is ultimately the cause of the NUL
bytes.  This case can be tested via the reproducer by setting
DO_FSTAT_AFTER_WRITE=1.

I haven't tested what happens in cached mode if you have two fds open to
the same file, one with O_APPEND and one without - not sure yet whether
the folio writeback will use the "correct" fid... but I somewhat suspect
the behaviour even for the non-append fd will not be correct if the
O_APPEND one is used?

The patch that follows is an attempt at fixing this.  Technically opening
the file with O_APPEND on the server side should be fine for uncached
mode, so I've preserved that, but I'm not 100% sure if there are any
problematic edge cases.

I did test, by having two cats pointing to the same file, one with ">" and
one with ">>", that the "two fd" situation is correctly handled when this
patch is applied.

Testing was done mainly on cache=none, cache=loose and cache=mmap modes,
but I also ran this reproducer and some previous ones over all caching bit
combinations from 0 to 15.  I also confirmed that the problem with
fish_history no longer reproduces.

reproducer-write-then-read.c:

#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

int main(int argc, const char **argv)
{
    int fd1, fd2;
    char buf[1024];
    ssize_t size;
    struct stat statbuf;
    size_t i;
    int ret;
    bool corrupted = false;
    size_t expected_total_size = 0;
    bool do_fstat_after_write = false;
    const char *expected_final_content = "Hello\nGoodbye\n";

    if (argc != 2) {
        fprintf(stderr, "Usage: %s <file>\n", argv[0]);
        return 1;
    }

    if (getenv("DO_FSTAT_AFTER_WRITE") != NULL) {
        do_fstat_after_write = true;
    }

    unlink(argv[1]);

    fd1 = open(argv[1], O_WRONLY | O_APPEND | O_CREAT, 0644);
    if (fd1 < 0) {
        perror("open fd1");
        return 1;
    }

    size = sprintf(buf, "Hello\n");

    errno = 0;
    if (write(fd1, buf, size) != size) {
        perror("write");
        close(fd1);
        return 1;
    }

    expected_total_size += size;

    if (do_fstat_after_write) {
        ret = fstat(fd1, &statbuf);
        if (ret < 0) {
            perror("fstat");
            close(fd1);
            return 1;
        }

        if (statbuf.st_size != expected_total_size) {
            fprintf(stderr, "File size returned by fstat mismatch after writes (1)\n");
            corrupted = true;
        }
    }

    sync();

    size = sprintf(buf, "Goodbye\n");

    errno = 0;
    if (write(fd1, buf, size) != size) {
        perror("write");
        close(fd1);
        return 1;
    }

    expected_total_size += size;

    if (do_fstat_after_write) {
        ret = fstat(fd1, &statbuf);
        if (ret < 0) {
            perror("fstat");
            close(fd1);
            return 1;
        }

        if (statbuf.st_size != expected_total_size) {
            fprintf(stderr, "File size returned by fstat mismatch after writes (2)\n");
            corrupted = true;
        }

        size = sprintf(buf, "Final goodbye\n");
        errno = 0;
        if (write(fd1, buf, size) != size) {
            perror("write");
            close(fd1);
            return 1;
        }

        expected_total_size += size;
        expected_final_content = "Hello\nGoodbye\nFinal goodbye\n";
    }

    fsync(fd1);

    close(fd1);
    sync();

    printf("Try reading %s from the host now.\nPress Enter to continue...\n", argv[1]);
    getchar();

    fd1 = open("/proc/sys/vm/drop_caches", O_WRONLY);
    if (fd1 < 0) {
        perror("open drop_caches");
        return 1;
    }
    errno = 0;
    if (write(fd1, "1\n", 2) != 2) {
        close(fd1);
        perror("write");
        return 1;
    }
    close(fd1);

    fd2 = open(argv[1], O_RDONLY);
    if (fd2 < 0) {
        perror("open fd2");
        return 1;
    }

    if ((size = read(fd2, buf, sizeof(buf))) < 0) {
        close(fd2);
        perror("read");
        return 1;
    }

    if (size != expected_total_size) {
        fprintf(stderr, "File size mismatch after reopen\n");
        corrupted = true;
    }

    close(fd2);
    close(fd1);

    fprintf(stdout, "File content:\n");
    for (i = 0; i < size; i++) {
        if (buf[i] == '\0') {
            corrupted = true;
            printf("\\0");
        } else {
            printf("%c", buf[i]);
        }
    }

    if (memcmp(buf, expected_final_content, expected_total_size) != 0) {
        fprintf(stdout, "\nFile content mismatch\n");
        corrupted = true;
    }

    if (corrupted) {
        fprintf(stdout, "\nFile corrupted\n");
        return 1;
    }

    return 0;
}

Tingmao Wang (1):
  fs/9p: Do not open remote file with APPEND mode when writeback cache
    is used

 fs/9p/vfs_file.c       | 13 +++++++++++--
 fs/9p/vfs_inode.c      |  7 ++++++-
 fs/9p/vfs_inode_dotl.c |  6 ++++++
 3 files changed, 23 insertions(+), 3 deletions(-)


base-commit: 98bd8b16ae57e8f25c95d496fcde3dfdd8223d41
-- 
2.51.2

