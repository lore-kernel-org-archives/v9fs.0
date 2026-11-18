Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795004524;
	b=q0RZ/zRI39ZS+k6NSdo7zZ184CYoYYDwL//BdVIC+RhnwT5y3gBq0HDroh9grqXoeK52
	 ZOT6dRAJ8m42z/eC5slRiRhRXDDGyvSdmPXTmeN7TuBqLcRxpiLbc0s6WMEoWaHfQR91G
	 MqbotMTQOrPXS4ksPWfga8L3O8q/ch04sWZMWBksLqqfM6xDnO/DiOzHWGLD10E0p4eW1
	 eJ/1nhcQxnjfjbKsfGjYWghx+ruDUhNNGope49G+UC4JMEVLvLTeCNQmOZL6MCExxm7jz
	 XIzHDQThiABKMh/SSFc2IuOg5KQPxKlNWOeHKR9t+U8KAs7Sp3Hr3IhLfetRtwQKITA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795004524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=yVl1P/S8CqE+KnNB3DCTb4bcglzeYdTS6qKSH1zjmsk=;
	b=g1syt81kR59Xi/NzQ1KplDpTgQCsfDDjQ1BSkrlJNS8ev72oSY4HPhvH/W52FOavCMWC
	 60BXPnx2frIhJVKCgrX3A5dmTFSKPWVHxn6gwu1fJILfPsPPY6GAGKM3ULaS3zqBLmM7y
	 HcNlNpLdWubo4nbj5F8CnGTr1/5nd4BENcAfq8OLQX2uxCUofzCsJEbawtGs1avXMRcUE
	 6T+/wLbnZoLDWmGSAOQklKzvIBSqdm8xWSfXVVKRipN8hvYTfiocZt55YkDYhHIxa6OO2
	 2quWWboHF/nEyONfPqNAKN7Mqj7W0pS8fawx5zn8ExrMT9AWb64n4B7aacpWj5Ow4rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=method-b.uk;
	spf=pass smtp.mailfrom=method-b.uk;
	dkim=pass header.d=method-b.uk header.i=@method-b.uk header.a=rsa-sha256 header.s=google header.b=AbPQhUKk;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C8F606A32A
	for <v9fs@lists.linux.dev>; Wed, 18 Nov 2026 12:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4C8F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=method-b.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=method-b.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=method-b.uk header.i=@method-b.uk header.a=rsa-sha256 header.s=google header.b=AbPQhUKk
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-49465892f7bso649739f8f.1
        for <v9fs@lists.linux.dev>; Wed, 18 Nov 2026 04:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=method-b.uk; s=google; t=1795004522; x=1795609322; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yVl1P/S8CqE+KnNB3DCTb4bcglzeYdTS6qKSH1zjmsk=;
        b=AbPQhUKkdPMrKD0Q1BYs6fGoZITWV31ajIm6bMPU/diOmtw7/REUrQwdohCtjdnFvD
         6SorlD/wRWNs5mqp11zHGG7r/3bfYIjmf0YasZ9nBQkooSaVdezOhfgJBjd1lxtGCFpG
         mi0uXc3igrU6oHN5Hb9n94AbSbHk3CYa5wVW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795004522; x=1795609322;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yVl1P/S8CqE+KnNB3DCTb4bcglzeYdTS6qKSH1zjmsk=;
        b=Xnwvaf0pXgWz+osuqkMamXzhpPJXdVfpumu3+Y2Cd1zUgRb7afz8hJ5kAIpD9RRQ0x
         IbXuzHhGIYKytgfWhtDMYwb4TCWMOdD1D7DEnTmNCVCW+MhJT7Q71E3E39LzasdDkIQ+
         /BKwebH5g9wXlvCad4KsMV1y0QNaRwwzIAk8vqa1wJOWT/683Q28fWW/PKtHHA/8sJwR
         wzKAh9VCiI7yo/UQ3DgkTt8AVOYP++zwO8YxGIp21SgpTRnhH/c30zxGZJ+9P8C01WLw
         dgH7lOKTVaUGN6yrl98CfTLELjNbrzvG36IWbhIVL6QVHMu7mS53hB5n0vYuRmkvw6A4
         R7Yg==
X-Forwarded-Encrypted: i=1; AL+hErGIqnaz7bM7rJg00v23BlMe3FFVUIew3uWiQqIvkctDtIJiq3ZMlKSl2Mf0QwQ9lANoDAeO@lists.linux.dev
X-Gm-Message-State: APuU4Z/iayBpTHTBEBqBk6evcx/FmM1VLTNYqWbFoyjqjhKbwKjNIS/A
	MBbz8SChD/xhS5OA2OWkSgYcpoHRtbYX1p9VZoM6DZ9qq6wLMe8cJlfK1BjGiKTbqH0=
X-Gm-Gg: AZFdTZerJbi0Qw1Br4Eo/DWD65cvcrR7d0p7byp6enH6RrbJ8nAQE9jwGvs/TrCrZMt
	6sBTw1HnlzIN+qyayvn2o+0XBMiM+NMb1qWyViGizJsgGnwhQNJjB4omWSYOCfDSluYEhqEYHwU
	+UEkv/cMwzBFCrP0YyPKWnD9pBW7UFUJzdsur3H9koLQjFyLUGYmT0duPVqpoKUR7Uct3VZG71R
	nw2DiYgbWfi5QUiFh39F4WbxBDYWuD9GIfRmS59mLNsod2EMQOuPCaSFnAzuOd0jASCdtL2t13Z
	IxtNxrmh8yRy15PSFruuTvjw0aLXY1jFboWq5HUA4EVji43qRAqCJqk8V18sVcYFOhS2D6+22l6
	WuZwqsxt3jbn8Cmm4L9Tk1tgVDpgUDyfiUoI2EO8ReL0t0Cqmq2VEjKq0/7oibgnT9PrR/FQMq3
	P0AO2J/Z4jhwJdyCHTzeQmhWBaJhmXvEdUV9LmdFH6zBqCvHgKOODuppGYCuZmL1HGrLWLt5aEV
	T64rwFey5WDBzggUacFEYwdKtWVzlUdGPlJGtTc57pAom2wLU3fM2xkNoHTNL5Wlq1TsYy77mNN
	SjTjwxYW0c53fPCq9qINENCrQvgpYp7TwLl6/LOntc3ypl/UQ0h35Y3rrRWSS9sSbL9KyiVOsZo
	249/Z91swR8dMYVEzP1gCNPKrBVTvKBXbReBX7UzXRDA=
X-Received: by 2002:a05:6000:2f85:b0:491:92e5:b5c2 with SMTP id ffacd0b85a97d-4a63947578dmr5837947f8f.15.1795004522038;
        Wed, 18 Nov 2026 04:22:02 -0800 (PST)
Received: from [192.168.1.182] ([193.9.15.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a655f9f53dsm4302059f8f.35.2026.11.18.04.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 04:22:01 -0800 (PST)
Message-ID: <e2c960ca-7b29-45e1-b650-849fc357f8b0@method-b.uk>
Date: Wed, 18 Nov 2026 12:22:00 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 9p: fix data corruption with writeback caching during
 concurrent stat
To: David Howells <dhowells@redhat.com>, Pierre Barre <pierre@barre.sh>
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 linux_oss@crudebyte.com, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251227083751.715152-1-pierre@barre.sh>
 <1667424.1771432276@warthog.procyon.org.uk>
Content-Language: en-US
From: Michael Mulqueen <mike@method-b.uk>
In-Reply-To: <1667424.1771432276@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I've encountered this bug and have spent some time confirming it and
writing a minimal reproducer script for it.

I've bisected it with my reproducer script and found it was introduced
in v6.4, specifically commit d9bc0d11e33b. I wasn't sure about the
etiquette of jumping straight into a discussion and tagging regzbot, so
I haven't, but I'm pretty confident that this is where the regression
was introduced. That is the commit that adds the writeback path -
before it, cache=mmap did not buffer writes through the page cache, so
a stale getattr had no unsent data to zero.

I cannot reproduce it on cache=readahead, only on the writeback path
that cache=mmap uses.

The reproducer writes with O_APPEND in one thread while another thread
stats the file and then reads the server copy back at the end. It
writes for a fixed period of 5 seconds, which is why the number of
records in the output differs, but it reproduces reliably on every run.
It needs diod installed and has to be run as root. Here's the output on
the current v7.3 release:

cache=mmap: appending for 5s while a reader stat()s the file...
  -> 689268 NUL bytes in the server's copy, 13897 of 16642 records lost
cache=readahead: appending for 5s while a reader stat()s the file...
  -> 0 NUL bytes in the server's copy, 0 of 10179 records lost

I have tried the fixes (Pierre Barre's v1 and v2, 27 December 2025, and
David Howells' sketch, 18 February 2026) discussed in this thread and
they appear to resolve it in the basic case. Pierre's apply cleanly to
v7.3; David's I rebased by hand (its step 5 is already present as
c60ae98c5aa6). My reproducer is too minimal to address all the points
raised in this thread, it only confirms that it's still present in the
latest kernel and that it regressed from v6.3 to v6.4. I'll try to find
some more time in the next couple of weeks to test the patches 
comprehensively, but I wanted toshare what I already have in case it is
useful to anyone else looking into this.

--- repro-b.py --------------------------------------------------------

#!/usr/bin/env python3
import os, re, shutil, socket, subprocess, tempfile, threading, time

base = tempfile.mkdtemp(prefix="p9b.")
exp = base + "/export"
mnt = base + "/mnt"
os.mkdir(exp)
os.mkdir(mnt)

port = 5700 + os.getpid() % 200
srv = subprocess.Popen(
    ["diod", "-f", "-n", "-l", f"127.0.0.1:{port}", "-e", exp],
    stderr=subprocess.PIPE)
for _ in range(100):
    try:
        socket.create_connection(("127.0.0.1", port), 0.2).close()
        break
    except OSError:
        time.sleep(0.05)
else:
    srv.terminate()
    raise SystemExit("diod failed to start:\n"
                     + srv.stderr.read().decode())
print(f"diod up on 127.0.0.1:{port}", flush=True)


def run(mode, seconds=5):
    opts = (f"trans=tcp,port={port},version=9p2000.L,cache={mode},"
            f"aname={exp},uname=root,access=any,ignoreqv")
    subprocess.run(["mount", "-t", "9p", "-o", opts,
                    "127.0.0.1", mnt], check=True)
    log = mnt + "/app.log"
    open(log, "w").close()
    print(f"cache={mode}: appending for {seconds}s while a reader "
          f"stat()s the file...", flush=True)

    stop = threading.Event()

    def poll():
        while not stop.is_set():
            try:
                os.stat(log)
            except OSError:
                pass

    threading.Thread(target=poll, daemon=True).start()

    fd = os.open(log, os.O_WRONLY | os.O_APPEND)
    n = 0
    end = time.time() + seconds
    while time.time() < end:
        os.write(fd, b"%08d " % n + b"x" * 90 + b"\n")
        n += 1
    os.fsync(fd)
    os.close(fd)
    stop.set()

    data = open(exp + "/app.log", "rb").read()
    nul = data.count(0)
    intact = len(set(re.findall(rb"(\d{8}) x{90}", data)))
    subprocess.run(["umount", "-l", mnt], stderr=subprocess.DEVNULL)
    print(f"  -> {nul} NUL bytes in the server's copy, "
          f"{n - intact} of {n} records lost", flush=True)


try:
    run("mmap")
    run("readahead")
finally:
    srv.terminate()
    srv.wait()
    shutil.rmtree(base, ignore_errors=True)

--- end repro-b.py ----------------------------------------------------

Cheers,
Mike
