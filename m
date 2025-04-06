Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1918F7D
	for <v9fs@lists.linux.dev>; Sun,  6 Apr 2025 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743956378; cv=none; b=QJZm6Z9NhdJAmUINvwpVvJe9lZuCgvTH7S7GZ3dJ2J8fJ4kJUCV0JwWdJnANwb+RCarGWa+Wbn24IsobIFC1uvkJ/EoH/v/MS7/up9QDevzJFtzdmCMspFZ7QlOA6TlSXNOf7DNZ4NjWpHHPfjEAULURNW7qpg33Z2rsPYB62S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743956378; c=relaxed/simple;
	bh=Pl0ltuF/LpM8O89D8M09Jw6nrmdBVTe6jlsbx54L9xM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q9M7AfRgfZoi1YoMJwC0R5bhMx9fdPSCdba6fiadQl3+FVCn/HtcDdqUppkkzoRAbds73nKSOpfxISBgBPL9wSlssh03yG77Jmqzg9DDuaI85zgp2cIQRmi7VRSDa4vEQ9pQqcwIiwUMdpvMSDw4JAi/SezKArK0Lws1251+l7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=gqdgtoUx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ijY0UNvk; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="gqdgtoUx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ijY0UNvk"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailflow.stl.internal (Postfix) with ESMTP id 047A11D41A15;
	Sun,  6 Apr 2025 12:19:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sun, 06 Apr 2025 12:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1743956373; x=1743959973; bh=zGk3xVMCMDmeiYaafhJvs
	Es6tB6dAPcFf6AHdAGF+iQ=; b=gqdgtoUxllVa7wFLSAi96jrgX109M99osQVCZ
	oRR+e2j/0pC0Yc2eTuPvA10LzQshlZjZj0L9Xo2nIldwrcoZSOFE83hFbyTGxntP
	LO4w/H12B8lCtANNo0K7VSFp87ShA5tZdtAIkFKB2T+HJ5q2m9KIswAPFmfCQ03F
	mi2DrcCiXCiXncjOgfhE4HLIh9hH5WA28zYAHeMdYW3fwqgpLx/BOGJWeyNOy4Ve
	XsvnNJhda/xKbhL5yf7AjU08tdrZmtCh8uqUhSSg/yGRElHgDAV3h/p72Gaq2DSf
	ZlCBgwW/OM9CtlW/yMO9lEWD/zpikAnN6YbJqbOFIZ7ZWVTCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743956373; x=1743959973; bh=zGk3xVMCMDmeiYaafhJvsEs6tB6dAPcFf6A
	HdAGF+iQ=; b=ijY0UNvkkH+KZQ2b4xqygbGXw03Dv09leA4QCnzvKjYfntvzz0b
	8CuAJ1LvoLbfZFDXvpF5iwLnUKKlR8E9n84I7SZbkyD3GgL2uCXtr1azZS8Vw2Ht
	RdoCRrG9l6WqwW8MDA3efCJTe33GGqkbIA1Ii3cUQ6wgHgf4gIkQLHOB3Yvw9Rh2
	Bnql89KDtrLSkTgh83Irj67Tu5OfI4zUt9PRn28dx36jBJdc3uw8Mk13k3XW1MyV
	W5m5kqGnlHPHJ9aZYL1xWEIEMcZPPjl4qjN49kJz0X7MyvvRgs39JU3TBlIgKmNa
	qYzQzTsYLSi/UZFwK0LVhVGHjLD2XBB+eqA==
X-ME-Sender: <xms:lKnyZ_cMYpICSXf9JElpy5rY-qnxj8skKwYvK3KcKY57kAGSvDDVGg>
    <xme:lKnyZ1OLD9nATZ9SL1ZaM3DKn6muzMj9FPokCP9wHcRySyWHzAmU93lVfxzQbcLg3
    qqw-C-KDmXv0MHpmYE>
X-ME-Received: <xmr:lKnyZ4g8r8R3Cdx1-ljyP4vvBvmyz7aDaBDAJpSsP_aBoJ-zqvE09MbyoteYRiJdU0ckPBBeJfNEwBrc7DIRFiWDMW413AOqBC7xUcJ4lt8BqP-15H4OkK0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleejjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttden
    ucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeejvedtkefhveetjeekleegleeiheeuueetleeftedvieffieev
    gfekieeiffevgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghrihgtvhhhsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrshhmrgguvghushestghouggvfihrvggtkhdrohhrghdprhgtphhtthhopehl
    uhgthhhosehiohhnkhhovhdrnhgvthdprhgtphhtthhopehlihhnuhigpghoshhssegtrh
    huuggvsgihthgvrdgtohhmpdhrtghpthhtohepmhesmhgrohifthhmrdhorhhgpdhrtghp
    thhtohepvhelfhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepmhhitg
    esughighhikhhougdrnhgvth
X-ME-Proxy: <xmx:lKnyZw9iQjHBn0MRqgnNx6DC9BXrr0aJa9okzHEnwvOuL6-w4qBSzw>
    <xmx:lKnyZ7v-dEEDwsWawO1vZ7FLiSwkAwmnmgjlBeuwuvz_4T00vHJd5A>
    <xmx:lKnyZ_ET93r3O2qKJo8agqyX_kedPnz4mUBuecORX1CYOIPrK77GHA>
    <xmx:lKnyZyOV5ylFJ6WLs0Iy-XeTdGRfx1rhLgvi_hR18QyaRddc_FsnXw>
    <xmx:lanyZz5BLBq5hTeCOXvcDi03eBdhZVlPodz5wBegAWSqf-KwrCLQIZyc>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Apr 2025 12:19:31 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Tingmao Wang <m@maowtm.org>,
	v9fs@lists.linux.dev,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Subject: [PATCH 0/3] fs/9p: d_revalidate changes and using it for uncached mode
Date: Sun,  6 Apr 2025 17:18:41 +0100
Message-ID: <cover.1743956147.git.m@maowtm.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi 9p-fs maintainers,

This patchset fixes a bug I've noticed while testing 9pfs with Landlock,
although this is not otherwise related to Landlock.  The main gist of the
fix is in the first patch, quoting the message here:

> Currently if another process keeps a file open, due to existing dentry in
> the dcache, other processes will not see updated metadata of that file if
> it is changed on the server, even in uncached mode.
>
> This can also manifest as -ENODATA when reading a file that has shrunk on
> the server (even if it's re-opened in another process), or -ENOTSUPP if
> the file has changed type (e.g. regular file to directory) on the server.
> We can end up in a situation where both `readdir` or `read` fails until
> the file is closed by all processes using it.

Here is a sample program that can be used to reproduce this issue.  It
takes a filename as argument and keeps that file open.

    #include <unistd.h>
    #include <stdio.h>
    #include <fcntl.h>
    #include <stdbool.h>

    int main(int argc, char const *argv[])
    {
        if (argc < 2) {
            printf("Usage: %s <filename>\n", argv[0]);
            return 1;
        }
        const char *filename = argv[1];
        int fd = open(filename, O_RDONLY);
        if (fd < 0) {
            perror("open");
            return 1;
        }
        while (true) {
            char buf[4096];
            ssize_t bytes_read = read(fd, buf, sizeof(buf)-1);
            if (bytes_read < 0) {
                perror("read");
                return 1;
            }
            buf[bytes_read] = '\0';
            printf("Read %zd bytes: %s\n", bytes_read, buf);
            printf("Press Enter to read again or Ctrl+C to exit...\n");
            while (getchar() != '\n') {}
            lseek(fd, 0, SEEK_SET);
        }
        return 0;
    }

There are two kinds of error. For -ENODATA:

On the server, prepare a folder with a file that initially has a longer content:

    # mkdir -p /tmp/linux-test
    # echo aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa > /tmp/linux-test/readme

Export the folder with 9pfs, and mount it in a QEMU guest with 9p share:

    guest # mount -t 9p -o trans=virtio,version=9p2000.L,debug=9,cache=none test /mnt
    [   16.254728][  T163] 9pnet: -- v9fs_mount (163):  simple set mount, return 0

Run openread in the background:

    guest # ./openread /mnt/readme &
    [1] 164
    guest # [   27.159295][  T164] 9pnet: -- v9fs_vfs_lookup (164): dir: ffff888105590000 dentry: (readme) ffff888102f0e000 flags: 0
    [   27.159827][  T164] 9pnet: -- v9fs_fid_find (164):  dentry: / (ffff888102f0d780) uid 0 any 0
    [   27.160161][  T164] 9pnet: -- v9fs_fid_find_inode (164):  inode: ffff888105590000
    [   27.160464][  T164] 9pnet: -- v9fs_fid_find (164):  dentry: / (ffff888102f0d780) uid 0 any 0
    [   27.160720][  T164] 9pnet: -- v9fs_fid_find_inode (164):  inode: ffff888105590000
    [   27.160913][  T164] 9pnet: -- v9fs_fid_find (164):  dentry: / (ffff888102f0d780) uid 0 any 0
    [   27.161130][  T164] 9pnet: -- v9fs_fid_find_inode (164):  inode: ffff888105590000
    [   27.162124][  T164] 9pnet: -- v9fs_vfs_lookup (164): readme -> qid->path 51094
    [   27.163190][  T164] 9pnet: -- v9fs_file_open (164): inode: ffff888105590648 file: ffff88810a779c00
    [   27.163679][  T164] 9pnet: -- v9fs_fid_find (164):  dentry: readme (ffff888102f0e000) uid 0 any 0
    [   27.165294][  T164] 9pnet: -- v9fs_file_read_iter (164): fid 3 count 4095 offset 0
    Read 68 bytes: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa

    Press Enter to read again or Ctrl+C to exit...

Shrink the file on the server:

    # echo aa > /tmp/linux-test/readme

Try to read it in the client.  Note that this is from a new process -- the
original openread process would also fail with the same error if we `fg`
then press enter on it.

    guest # head /mnt/readme
    [   75.992862][  T165] 9pnet: -- v9fs_file_open (165): inode: ffff888105590648 file: ffff888107aeaf40
    [   75.997456][  T165] 9pnet: -- v9fs_fid_find (165):  dentry: readme (ffff888102f0e000) uid 0 any 0
    [   75.999052][  T165] 9pnet: -- v9fs_file_read_iter (165): fid 4 count 8192 offset 0
    head: error reading '/mnt/readme': No data available
    [   76.001290][  T165] 9pnet: -- v9fs_dir_release (165): inode: ffff888105590648 filp: ffff888107aeaf40 fid: 4

Note that a stat will resolve the situation in this case, since that
updates the metadata.  It also happens that `cat` does a fstat, so using
`cat` to read the file would not reproduce this issue:

    guest # stat /mnt/readme
    [  371.948720][  T172] 9pnet: -- v9fs_vfs_getattr_dotl (172): dentry: ffff888102f0e000
    [  371.952462][  T172] 9pnet: -- v9fs_fid_find (172):  dentry: readme (ffff888102f0e000) uid 0 any 0
    File: /mnt/readme
    Size: 3         	Blocks: 8          IO Block: 131072 regular file
    guest # head /mnt/readme
    [  373.141565][  T173] 9pnet: -- v9fs_file_open (173): inode: ffff888105590648 file: ffff8881071f32c0
    [  373.141969][  T173] 9pnet: -- v9fs_fid_find (173):  dentry: readme (ffff888102f0e000) uid 0 any 0
    [  373.143636][  T173] 9pnet: -- v9fs_file_read_iter (173): fid 4 count 8192 offset 0
    aa
    [  373.145526][  T173] 9pnet: -- v9fs_file_read_iter (173): fid 4 count 8192 offset 3
    [  373.146358][  T173] 9pnet: -- v9fs_dir_release (173): inode: ffff888105590648 filp: ffff8881071f32c0 fid: 4

The other failure mode, which is perhaps less common but more problematic,
is when the file changes type on the host.  Continuing the above, on the
server:

    # rm /tmp/linux-test/readme
    # mkdir /tmp/linux-test/readme

Now the file/dir is inaccessible in the client:

    guest # cat /mnt/readme
    [  509.682250][  T177] 9pnet: -- v9fs_file_open (177): inode: ffff888105590648 file: ffff88810b2756c0
    [  509.682836][  T177] 9pnet: -- v9fs_fid_find (177):  dentry: readme (ffff888102f0e000) uid 0 any 0
    [  509.688049][  T177] 9pnet: -- v9fs_vfs_getattr_dotl (177): dentry: ffff888102f0e000
    [  509.691997][  T177] 9pnet: -- v9fs_fid_find (177):  dentry: readme (ffff888102f0e000) uid 0 any 0
    [  509.696235][  T177] 9pnet: -- v9fs_file_read_iter (177): fid 4 count 131072 offset 0
    qemu-system-x86_64: warning: 9p: bad client: T_read request on directory only expected with 9P2000.u protocol version
    cat: /mnt/readme: Operation not supported
    [  509.700970][  T177] 9pnet: -- v9fs_dir_release (177): inode: ffff888105590648 filp: ffff88810b2756c0 fid: 4
    guest # ls /mnt/readme/
    ls: cannot access '/mnt/readme/': Not a directory

Both issues are fixed by this patchset, with the debug prints added in
commit #3 shown below:

    ... Same setup as before, readme is a long file, we "openread" it,
    shortens it on the host, then read it with head ...

    guest # head /mnt/readme
    [  114.024938][  T196] 9pnet: -- v9fs_fid_find (196):  dentry: readme (ffff8881075d0758) uid 0 any 0
    [  114.026228][  T196] 9pnet: -- __v9fs_lookup_revalidate (196): dentry: readme (ffff8881075d0758) is valid
    [  114.026596][  T196] 9pnet: -- v9fs_file_open (196): inode: ffff8881074b8c90 file: ffff88810bee7480
    [  114.026971][  T196] 9pnet: -- v9fs_fid_find (196):  dentry: readme (ffff8881075d0758) uid 0 any 0
    [  114.027970][  T196] 9pnet: -- v9fs_file_read_iter (196): fid 4 count 8192 offset 0
    aa
    [  114.029430][  T196] 9pnet: -- v9fs_file_read_iter (196): fid 4 count 8192 offset 3
    [  114.030204][  T196] 9pnet: -- v9fs_dir_release (196): inode: ffff8881074b8c90 filp: ffff88810bee7480 fid: 4

    ... Now change the file to a dir on the host ...

    root@d8c28a676d72:/# ls -lah /mnt/readme
    [  177.047326][  T197] 9pnet: -- v9fs_fid_find (197):  dentry: readme (ffff8881075d0758) uid 0 any 0
    [  177.048901][  T197] 9pnet: -- __v9fs_lookup_revalidate (197): dentry: readme (ffff8881075d0758) invalidated due to type change
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    [  177.049400][  T197] 9pnet: -- v9fs_vfs_lookup (197): dir: ffff8881074b8000 dentry: (readme) ffff888102ecc000 flags: 0
    [  177.049914][  T197] 9pnet: -- v9fs_fid_find (197):  dentry: / (ffff8881075ce5e0) uid 0 any 0
    ...
    [  177.095001][  T197] 9pnet: -- v9fs_fid_find (197):  dentry: readme (ffff888102ecf8f8) uid 0 any 0
    [  177.096224][  T197] 9pnet: -- v9fs_dir_readdir_dotl (197): name readme
    [  177.097073][  T197] 9pnet: -- v9fs_dir_release (197): inode: ffff888102f192d8 filp: ffff88810aebf640 fid: 5
    [  177.097616][  T197] 9pnet: -- v9fs_dentry_release (197):  dentry: readme (ffff888102ecf8f8)
    total 8.0K
    drwxr-x--- 2 1000 1000 4.0K Apr  6 15:20 .
    drwxr-x--- 7 1000 1000 4.0K Apr  6 15:20 ..

While I haven't measured the impact, I expect there to be performance hit
only when opening a file that's already open by another process in
uncached mode, due to the extra getattr request.  When a file is not
opened by anyone, it won't have a dentry due to the use of
always_delete_dentry, and thus this d_revalidate change isn't applicable.

Also, I decided to reuse the dentry and call v9fs_refresh_inode_dotl if
the type stayed the same, even in uncached mode.  From looking at the
usages of, and the comment in v9fs_refresh_inode_dotl, I believe this is
safe to do.

Let me know if you wants more testing -- I'm happy to do so.

Tingmao

Tingmao Wang (3):
  fs/9p: Refresh metadata in d_revalidate for uncached mode too
  fs/9p: Invalidate dentry if inode type change detected in cached mode
  fs/9p: Add p9_debug(VFS) in d_revalidate

 fs/9p/vfs_dentry.c     | 33 +++++++++++++++++++++++++++++----
 fs/9p/vfs_inode.c      |  8 +++++++-
 fs/9p/vfs_inode_dotl.c |  8 +++++++-
 3 files changed, 43 insertions(+), 6 deletions(-)


base-commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557
--
2.39.5
