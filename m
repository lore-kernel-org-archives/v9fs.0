Received: from wirbelwind.zhasha.com (wirbelwind.zhasha.com [78.109.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DF037B
	for <v9fs@lists.linux.dev>; Sat, 30 Mar 2024 06:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.109.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711781262; cv=none; b=Y4+00y6Df61mEaNFyeTNXQk5fOkNUxV/6hZJXSVR9vFoBlY6Fq+mETWh+78Qdqiien4jOTxXjArkuClDlhgyf/ESNuiCmVmsRUbuXVCql7oIqulwV7iiCkD2zw4P+x/l3Z6fOaZR01fpO3vFyu3ZLZY4OvtdrOy4ShTlHH6uGoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711781262; c=relaxed/simple;
	bh=AG5LqBQPVun8mpK4nHmaR2ZTthsgWEEwN2FakOnR/vw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KIcdVTrt4044ll50UnLbtJCMULZSMJ3pggux4DLB69RnS1o6Xx2JNjocc6RIOdohEhock/G+JZaR07RsjVCqzHeh+55FoZdsR1TLBhnXte34BWGS0tGnomxGjNvJ4+sIZwUvGgDYT4/w2RckKOtUIBdA8ocVuXxsXCYOIPTvfBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zhasha.com; spf=pass smtp.mailfrom=zhasha.com; dkim=pass (1024-bit key) header.d=zhasha.com header.i=@zhasha.com header.b=AzQJZY29; arc=none smtp.client-ip=78.109.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zhasha.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhasha.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zhasha.com header.i=@zhasha.com header.b="AzQJZY29"
Received: from eclair (unknown [192.168.0.238])
	by wirbelwind.zhasha.com (Postfix) with ESMTPSA id 6B8D4325329;
	Sat, 30 Mar 2024 07:47:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhasha.com;
	s=wirbelwind; t=1711781244;
	bh=0m7uF79Z6woXBGAacxzXXlW3bGHPc1vgjKFSv4zosXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AzQJZY29amsrGZcj2TKGmE1Y/40KRVzniMCq5K+RNJy5N61s0hWYHq3++jorLx15I
	 oaX2hOzM/q5t3YGLh/rlbc0eqlQFdg5ZbhOrR/WQlSJ4pfXaii4Xac1S+eD3a8cbsY
	 8HaZ/qURCTHlypslWNcaaKtw0wdf9EianbAxeNuY=
Date: Sat, 30 Mar 2024 07:47:22 +0100
From: Joakim Sindholt <opensource@zhasha.com>
To: "Eric Van Hensbergen" <eric.vanhensbergen@linux.dev>
Cc: v9fs@lists.linux.dev
Subject: Re: [PATCH v2 2/4] fs/9p: drop inodes immediately on non-.L too
Message-ID: <20240330074722.3032b802@eclair>
In-Reply-To: <4d7d7f9020fecc66d34c3b925591371e2aeac42f@linux.dev>
References: <20240318112542.18863-1-opensource@zhasha.com>
	<20240318112542.18863-3-opensource@zhasha.com>
	<145fc52b2452095c44260825670141d0d3b42c7d@linux.dev>
	<20240328163753.eb3541f4c8595de40f5e3c82@zhasha.com>
	<6a4f3bed800f9f5021e17311e6d7288f9a2b56c6@linux.dev>
	<4d7d7f9020fecc66d34c3b925591371e2aeac42f@linux.dev>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-gentoo-linux-musl)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 20:03:36 +0000 "Eric Van Hensbergen" <eric.vanhensbergen@linux.dev> wrote:
> March 28, 2024 at 2:47 PM, "Eric Van Hensbergen" <eric.vanhensbergen@linux.dev> wrote:
> > Not sure if your server source is public or not, but it would be
> > useful to test against it and see what I see. It's possible a
> > mismatch with the nlink stat information could indeed cause inodes
> > to stick around even under memory pressure and that'd cause all
> > sorts of problems.

It is public but I think it's far more helpful to have a minimal
reproducer rather than having you build my 9P library. It took me a
little while to get it working and it's not very well written, nor is it
particularly small at 540 lines but it does show the issue.

> > The newer kernel versions have much better qid->inode mapping stuff
> > that should provent some of the weirdness in the implementation
> > before (there were lots of inodes with duplicate ino_num because the
> > way we crushed the allocated inode number with the qid.path) so its
> > definitely worth testing against the latest and greatest if you can.
> > I will try and allocate some time to revive my regressions against
> > 9p2000 and 9p2000.u servers so we catch some of this earlier in the
> > future, but I'm not sure I would have caught any degredation.

For now I can't easily test with the latest but I can test with 6.6,
which I have done and can confirm it still happens. If you have a test
setup then you can run the reproducer. I've attached it at the bottom of
this mail.
I don't know whether this is a regression. As far as I can tell it's
always been a problem. I just didn't notice it because inodes are small
and the loads on my file servers were relatively meager. I only noticed
it due to a completely unrelated issue on the same machine which sent me
down this rabbit hole. The reproducer takes a long time to saturate RAM
and even then it doesn't cause OOM since linux does free what it needs
to from the cache when it needs to.

> Also digging a bit deeper -- looks like for legacy we set nlink to 1
> always.  So server doesn't have anything to do with that, and it may
> be a problem in the newer code that we aren't coping properly.  I
> guess I need to compare a legacy trace to a dotL trace and make sure
> that's right -- a bit worried about how directories show up since they
> should have 3 nlinks (. and ..) and this code looks generic.

I don't know if it has anything to do with nlink. The reason I added the
.drop_inode callback was because when looking at vfs it seemed to be the
one and only way the inodes would ever get explicitly freed from the
cache.
The reproducer only implements Tversion/attach/walk/open/clunk/stat, so
no Tread meaning you never see the stats from reading the directory. The
only thing it does is let you walk to a file called "file", stat it,
and open it (and stat the root dir as v9fs needs that too). The test
program that triggers the issue is literally just:

#include <fcntl.h>
#include <unistd.h>

int
main(int argc, char *argv[])
{
    while (1)
        close(open("/mnt/test/file", O_RDONLY));
    return 0;
}

As far as I can tell the issue is that open(2) calls Twalk for every
path component as well as Tstat after every successful 1-element walk,
and the code that calls Tstat puts an inode into the v9fs_inode_cache
that doesn't get removed until there's no more RAM to waste. Feel free
to play with my ugly test server yourself:

#include <unistd.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include <sys/mount.h>
#include <sys/socket.h>

typedef struct Req Req;

struct Req
{
    uint8_t type;
    uint16_t tag;
    uint32_t size;
    unsigned char *d;
};

enum {
    Msize = 8192,
};

enum {
    Froot = 1,
    Ffile,

    Fopen = 0x80,
};

static uint8_t fids[32];
static uint32_t iounit;
static uint32_t time0;

static int infd = 0, outfd = 1;
static int debug;

#define Filename "file"

enum {
    QTDIR = 0x80,
    QTFILE = 0,
};

#define DMDIR 0x80000000

enum {
    Tversion = 100,
    Rversion,
    Tattach = 104,
    Rattach,
    Rerror = 107,
    Twalk = 110,
    Rwalk,
    Topen = 112,
    Ropen,
    Tclunk = 120,
    Rclunk,
    Tstat = 124,
    Rstat,
};

static void version(Req *);
static void attach(Req *);
static void walk(Req *);
static void open9(Req *);
static void clunk(Req *);
static void stat9(Req *);

static Req *readreq(void);
static void respond(unsigned char *);
static void err(uint16_t, const char *);

static uint32_t r32(unsigned char *);
static void w32(unsigned char *, uint32_t);
static uint16_t r16(unsigned char *);
static void w16(unsigned char *, uint16_t);
static size_t wstr(unsigned char *, const char *);
static void wqid(unsigned char *, uint8_t, uint32_t, uint64_t);

int
main(int argc, char *argv[])
{
    char opts[128], eunsupp[128];
    Req *req;
    int fds[2];

    if (socketpair(AF_UNIX, SOCK_STREAM, 0, fds) != 0) {
        perror("socketpair failed");
        exit(1);
    }
    switch (fork()) {
    case -1:
        perror("fork failed");
        exit(1);
    case 0:
        close(fds[1]);
        sprintf(opts, "trans=fd,rfdno=%d,wfdno=%d,dfltuid=0,dfltgid=0", fds[0], fds[0]);
        if (mount("none", "/mnt/test", "9p", 0, opts) != 0) {
            perror("mount failed");
            exit(1);
        }
        exit(0);
    default:
        close(fds[0]);
        infd = outfd = fds[1];
        break;
    }

    while ((req = readreq()) != 0) switch (req->type) {
    case Tversion: version(req); break;
    case Tattach: attach(req); break;
    case Twalk: walk(req); break;
    case Topen: open9(req); break;
    case Tclunk: clunk(req); break;
    case Tstat: stat9(req); break;
    default:
        sprintf(eunsupp, "unsupported request %u", req->type);
        err(req->tag, eunsupp);
    }
    return 0;
}

static void
version(Req *req)
{
    uint32_t msize;
    uint16_t slen;
    char *version;
    unsigned char res[4+1+2+4+2+6];

    if (req->size < 4+2) {
        err(req->tag, "invalid Tversion");
        return;
    }
    msize = r32(&req->d[0]);
    slen = r16(&req->d[4]);
    if (req->size-4-2 < slen) {
        err(req->tag, "invalid Tversion version string");
        return;
    }
    version = (char *)&req->d[4+2];
    version[slen] = 0;

    if (debug)
        dprintf(2, "Tversion msize=%u version=%s\n", msize, version);

    if (msize < 128) {
        err(req->tag, "msize too small");
        return;
    }
    if (msize > Msize)
        msize = Msize;
    if (strncmp(version, "9P2000", 6) != 0) {
        err(req->tag, "unsupported version");
        return;
    }

    if (debug)
        dprintf(2, "Rversion msize=%u version=9P2000\n", msize);

    w32(&res[0], sizeof(res));
    res[4] = Rversion;
    w16(&res[4+1], req->tag);
    w32(&res[4+1+2], msize);
    wstr(&res[4+1+2+4], "9P2000");
    respond(res);

    iounit = msize-4-1-2-4-8-4;
    time0 = (uint32_t)time(0);
}

static void
attach(Req *req)
{
    uint32_t fid;
    unsigned char res[4+1+2+13];

    if (req->size < 4) {
        err(req->tag, "invalid Tattach");
        return;
    }
    fid = r32(&req->d[0]);
    if (fid >= sizeof(fids)/sizeof(*fids)) {
        err(req->tag, "too many fids");
        return;
    }
    /* ignore afid, uname, aname */

    if (debug)
        dprintf(2, "Tattach fid=%u\n", fid);
    if (debug)
        dprintf(2, "Rattach qid=0x%x.%u.%u\n", QTDIR, 0, Froot);

    w32(&res[0], sizeof(res));
    res[4] = Rattach;
    w16(&res[4+1], req->tag);
    wqid(&res[4+1+2], QTDIR, 0, Froot);
    respond(res);

    fids[fid] = Froot;
}

static void
walk(Req *req)
{
    const char *e;
    uint32_t fid, newfid;
    uint16_t nwname, i, j, slen;
    uint8_t oldfid;
    char *wname, save;
    unsigned char res[4+1+2+2+16*13];

    if (req->size < 4+4+2) {
        err(req->tag, "invalid Twalk");
        return;
    }
    fid = r32(&req->d[0]);
    if (fid >= sizeof(fids)/sizeof(*fids) || fids[fid] == 0 || (fids[fid]&Fopen)) {
        err(req->tag, "invalid fid");
        return;
    }
    newfid = r32(&req->d[4]);
    if (newfid >= sizeof(fids)/sizeof(*fids)) {
        err(req->tag, "too many fids");
        return;
    }
    if (fids[newfid]) {
        err(req->tag, "invalid newfid");
        return;
    }
    nwname = r16(&req->d[4+4]);
    if (nwname > 16) {
        err(req->tag, "walking too far");
        return;
    }
    oldfid = fids[newfid];
    fids[newfid] = fids[fid];
    req->size -= 4+4+2;
    req->d += 4+4+2;
    if (debug)
        fprintf(stderr, "Twalk fid=%u newfid=%u nwname=%u", fid, newfid, nwname);
    for (i = 0; i < nwname; i++) {
        if (req->size < 2 || req->size-2 < (slen = r16(&req->d[0]))) {
            if (debug) {
                fprintf(stderr, "\n");
                fflush(stderr);
            }
            err(req->tag, "invalid Twalk wname");
            return;
        }
        wname = (char *)&req->d[2];
        save = wname[slen];
        wname[slen] = 0;

        if (debug)
            fprintf(stderr, " %s", wname);
        if (strcmp(wname, Filename) == 0) {
            if (fids[newfid] != Froot) {
                e = "file not found";
                break;
            }
            fids[newfid] = Ffile;
            wqid(&res[4+1+2+2+(uint32_t)i*13], QTFILE, 0, Ffile);
        } else if (strcmp(wname, "..") == 0) {
            fids[newfid] = Froot;
            wqid(&res[4+1+2+2+(uint32_t)i*13], QTDIR, 0, Froot);
        } else {
            e = "file not found";
            break;
        }

        wname[slen] = save;
        req->d += 2+slen;
        req->size -= 2+slen;
    }
    if (debug) {
        fprintf(stderr, "\n");
        fflush(stderr);
    }
    if (i != nwname) {
        fids[newfid] = oldfid;
        if (i == 0) {
            err(req->tag, e);
            return;
        }
    }
    if (debug) {
        fprintf(stderr, "Rwalk");
        for (j = 0; j < i; j++)
            fprintf(stderr, " 0x%x.%u.%u", res[4+1+2+2+j*13+0], r32(&res[4+1+2+2+j*13+1]), r32(&res[4+1+2+2+j*13+1+4]));
        fprintf(stderr, "\n");
        fflush(stderr);
    }

    w32(&res[0], 4+1+2+2+(uint32_t)i*13);
    res[4] = Rwalk;
    w16(&res[4+1], req->tag);
    w16(&res[4+1+2], i);
    respond(res);
}

static void
open9(Req *req)
{
    uint32_t fid;
    uint8_t mode;
    unsigned char res[4+1+2+13+4];

    if (req->size < 4+1) {
        err(req->tag, "invalid Topen");
        return;
    }
    fid = r32(&req->d[0]);
    if (fid >= sizeof(fids)/sizeof(*fids) || fids[fid] == 0 || (fids[fid]&Fopen)) {
        err(req->tag, "invalid fid");
        return;
    }
    mode = req->d[4];

    if (debug)
        dprintf(2, "Topen fid=%u mode=%u\n", fid, mode);

    if (mode != 0 /*OREAD*/) {
        err(req->tag, "permission denied");
        return;
    }

    if (debug)
        dprintf(2, "Ropen qid=%u.%u.%u iounit=%u\n", fids[fid]==Ffile?QTFILE:QTDIR, 0, fids[fid], iounit);

    w32(&res[0], sizeof(res));
    res[4] = Ropen;
    w16(&res[4+1], req->tag);
    wqid(&res[4+1+2], fids[fid]==Ffile?QTFILE:QTDIR, 0, fids[fid]);
    w32(&res[4+1+2+13], iounit);
    respond(res);

    fids[fid] |= Fopen;
}

static void
clunk(Req *req)
{
    uint32_t fid;
    unsigned char res[4+1+2];

    fid = r32(&req->d[0]);
    if (fid >= sizeof(fids)/sizeof(*fids) || fids[fid] == 0) {
        err(req->tag, "invalid fid");
        return;
    }

    if (debug)
        dprintf(2, "Tclunk fid=%u\n", fid);
    if (debug)
        dprintf(2, "Rclunk\n");

    w32(&res[0], sizeof(res));
    res[4] = Rclunk;
    w16(&res[4+1], req->tag);
    respond(res);

    fids[fid] = 0;
}

static void
stat9(Req *req)
{
    const char *name;
    uint32_t fid;
    unsigned char res[1024], *r;

    fid = r32(&req->d[0]);
    if (fid >= sizeof(fids)/sizeof(*fids) || fids[fid] == 0) {
        err(req->tag, "invalid fid");
        return;
    }

    if (debug)
        dprintf(2, "Tstat fid=%u\n", fid);

    res[4] = Rstat;
    w16(&res[4+1], req->tag);
    r = &res[4+1+2];
    r += 2; /* redundant size */
    r += 2; /* size */
    w16(r, 0); r += 2; /* type */
    w32(r, 0); r += 4; /* dev */
    if ((fids[fid]&~Fopen) == Froot) {
        wqid(r, QTDIR, 0, Froot); r += 13;
        w32(r, DMDIR|0555); r += 4;
        name = "/";
    } else {
        wqid(r, QTFILE, 0, Ffile); r += 13;
        w32(r, 0444); r += 4;
        name = Filename;
    }
    w32(r, time0); r += 4; /* atime */
    w32(r, time0); r += 4; /* mtime */
    w32(r, 0); w32(r+4, 0); r += 8; /* length */
    r += wstr(r, name);
    r += wstr(r, "someuser");
    r += wstr(r, "somegroup");
    r += wstr(r, "someotheruser");

    if (debug)
        dprintf(2, "Rstat %s\n", name);

    w32(&res[0], (uint32_t)(r-res));
    w16(&res[4+1+2], (uint16_t)(r-&res[4+1+2+2]));
    w16(&res[4+1+2+2], (uint16_t)(r-&res[4+1+2+2+2]));
    respond(res);
}

static Req *
readreq(void)
{
    static unsigned char d[Msize+1];
    static Req req;
    ssize_t r;
    size_t n;

    req = (Req){.size = 4};
    for (n = 0; n < req.size; n += (size_t)r) {
        if ((r = read(infd, d+n, req.size-n)) <= 0)
            break;
        if (n < 4 && n+(size_t)r >= 4) {
            req.size = r32(d);
            if (req.size < 4+1+2) {
                if (debug)
                    fprintf(stderr, "invalid packet\n");
                exit(1);
            }
            if (req.size >= sizeof(d)) {
                if (debug)
                    fprintf(stderr, "packet too large\n");
                exit(1);
            }
        }
    }
    if (n < req.size) {
        if (n == 0 || r == 0)
            exit(0);
        perror("incomplete packet");
        exit(1);
    }
    req.type = d[4];
    req.tag = r16(&d[4+1]);
    req.d = &d[4+1+2];
    req.size -= 4+1+2;
    return &req;
}

static void
respond(unsigned char *res)
{
    unsigned char *e = res+r32(res);
    ssize_t r;

    for (e = res+r32(res); res != e; res += (size_t)r)
        if ((r = write(outfd, res, (size_t)(e-res))) <= 0)
            break;
    if (res != e) {
        if (r == 0)
            exit(0);
        perror("write failed");
        exit(1);
    }
}

static void
err(uint16_t tag, const char *e)
{
    uint16_t len = (uint16_t)strlen(e);
    unsigned char res[4+1+2+2+len];

    if (debug)
        dprintf(2, "Rerror %s\n", e);

    w32(&res[0], sizeof(res));
    res[4] = Rerror;
    w16(&res[4+1], tag);
    w16(&res[4+1+2], len);
    memcpy(&res[4+1+2+2], e, len);
    respond(res);
}

static uint32_t
r32(unsigned char *d)
{
    return (uint32_t)d[3]<<24|(uint32_t)d[2]<<16|(uint32_t)d[1]<<8|d[0];
}

static void
w32(unsigned char *d, uint32_t v)
{
    *d++ = (unsigned char)v;
    *d++ = (unsigned char)(v>>8);
    *d++ = (unsigned char)(v>>16);
    *d++ = (unsigned char)(v>>24);
}

static uint16_t
r16(unsigned char *d)
{
    return (uint16_t)d[1]<<8|d[0];
}

static void
w16(unsigned char *d, uint16_t v)
{
    *d++ = (unsigned char)v;
    *d++ = (unsigned char)(v>>8);
}

static size_t
wstr(unsigned char *d, const char *s)
{
    uint16_t len = (uint16_t)strlen(s);
    w16(&d[0], len);
    memcpy(&d[2], s, len);
    return 2+(size_t)len;
}

static void
wqid(unsigned char *d, uint8_t type, uint32_t vers, uint64_t path)
{
    *d++ = type;
    w32(d, vers); d += 4;
    *d++ = (unsigned char)path;
    *d++ = (unsigned char)(path>>8);
    *d++ = (unsigned char)(path>>16);
    *d++ = (unsigned char)(path>>24);
    *d++ = (unsigned char)(path>>32);
    *d++ = (unsigned char)(path>>40);
    *d++ = (unsigned char)(path>>48);
    *d++ = (unsigned char)(path>>56);
}
