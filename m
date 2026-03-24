Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFCC243951
	for <v9fs@lists.linux.dev>; Tue, 24 Mar 2026 04:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774326485; cv=pass; b=BZvCe7wTySKLFpcdujZOr2PasjpvUe9wcbPmqT62bQcEIGhoRRImev0hGKSEXLuoTpQLxlalse44MC0F3cE9y/rXy2oQD26TqPmNXGwA0yb1MQ0wprcnydwxSzZlV6drNUlYAj2qwGEgnc/mPSSaJfvRM/9IfExIoDZxfwWysiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774326485; c=relaxed/simple;
	bh=svClQVwTYvLN+679sWWYhBctw/RFEPMWANDN/6NPjuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfzJhGJKbs5hoCtO002QKgwCdeEkLiymmlvQqA+m0T6fbXWa03glUR86KRvK7+fkXhCPAbgkjJCpd4U/anDR4YsJYlBUw/j8usEnh+MRuR4+FchpIweXynN9+3oXy9Nf/OjgHE1ptCARiYxmShzb7yJ8Ctt0BI/btCenmpqTXoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqbeDoI7; arc=pass smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqbeDoI7"
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-669efe709feso1509620a12.0
        for <v9fs@lists.linux.dev>; Mon, 23 Mar 2026 21:28:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774326482; cv=none;
        d=google.com; s=arc-20240605;
        b=Y/jXfsZzdKP3guvU2ofd7DwS99Y+Id4eDsyIxZW25EoLoCgT2+0iyPBMzvWT17qAz2
         8HCB6cAqx+bBNLN6TD8eUWi9k5bcnALjgKnSdybWYZY3+YUwE9tHtXns7N/x3nej+k3v
         gX3rZ8vz4QyagiLVT7xU/6l9H47UzLbGuOvV42oarixkl9ciIl/XZcLEJv4T+LN9SZsN
         D7dwzBUFR6CfBlGJVD+AuF+tU87BVPocXlW2pAkLcMEAOqavEuaM+F3xBgUtCCO5eg5o
         VzQr1D3hGkM5rH5dpQA7MvSEEvjcFaDQuu1Rn5z35k9UjT0Irw3Cw9WZWH3DWnMFVE5N
         6E5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=svClQVwTYvLN+679sWWYhBctw/RFEPMWANDN/6NPjuU=;
        fh=4uoDy1zNSPvkQfqOplrqGb6yfvMEO+c8UNbcG9M0xT0=;
        b=Lo7b882Xx0lNy4opJ6mVKVSjKIIeO9C3AOp+Pz6Sh4UwyPgIATKUyUalL/7Z0vOkkN
         1evu+o9WDdMYxdSYqNz401K1SwuAaHAJl2TjzVt1MGojnd6ffn1z4C64SGM3rHfiAWly
         AZUuhO2FtkqtCh5OweoCpx/KO/ju0bstQalabY1EXFFhd0iuzeXLKQtxN2TUsy/Gfrx8
         YZiEF6DSSe3HpNY72xhZnsHXh1xCg4kwZoGhxrIbC1zlLNNHNoEW5g1zgjRM1qgAilY+
         sNvH02XEBQOIAYIfUdG9/lPTOp7WSlibJKubw7vL+2MvA7EVhjBG/NUj5lrZ6dA/10Zi
         gxWQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774326482; x=1774931282; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svClQVwTYvLN+679sWWYhBctw/RFEPMWANDN/6NPjuU=;
        b=YqbeDoI7DQFiTUw3/1Lua5Bbo7A00Q0cz2bpkNTlOp/K2fOqG2NdFPUG0CRGeoziIj
         TxBw6llJI/EBEi66krOlxJPxxoPke+iiQjy2I91iLeCWNRZDcPhMb4hw7Kbb2SjZSEAy
         cDFLkqfIMzPZ77X6hWbbK1a2QdzxFTk6evO2rjlanC6+ShL3cLzaKU0l/WYPlkXVo3fh
         9b8LLR4tEIpHMW6xR56LU1SiGHbFcuhDj16ngfL3xOhlfikJBT5Uf1IZjaUJt0etbtt2
         ZQBulPrOFKQr1JKTkfjNIGTm0Ri2to+qnPWkK5ywRYC8jFCCPRgEPvtJ1wqD7GmrtIGP
         7hUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774326482; x=1774931282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=svClQVwTYvLN+679sWWYhBctw/RFEPMWANDN/6NPjuU=;
        b=BbgqGzH9mIh9CiBEdDL05JPndhgSzsKhHWrEFcQEtGC1jhSdGSDtD7om8WAxd1TZKq
         MyUoLJVluAREHrQTlIah1p3EZXeKl5cO6olTBuV7+8O4wRmo8OFfWjCcwZocDlWvIGXS
         zvwSmGziRfrTRWO/Ad7GR60gKN4TGmx1RY6AmA5UG08jxVLrfVRyIXvdlWTQ0Obj3gZC
         QfebDB2D8+JVf6jHJ/AtJEC3gzpI7SlvpEVjFxvw1TSA5bSuvQHh33dRub8SUmbxxetQ
         eU/K6FidxDujzdocoQnETYNBd/8WLq9zAf5OnFrDPKtWYfqZCdCUC0DbC6P1UgmNqLBt
         p6ng==
X-Forwarded-Encrypted: i=1; AJvYcCWAgjF4cH1mtrC3v0e/TE57RU9sAbBlCQ2noBpLZK3EvkTvdIJlsvI6CJeW0bm+l8G9QrcP@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+hpR0wSiTznzbEfiR9qDlIB0TpA0gidf2enr8NCy9wj0RoWlv
	Zgzdbc021EOidVaPmT9BgSEGmlNbrVwK2wcIbNQ/hCTNJ/P02GuiRwyq2IDBOAp6yxL5etUCFh9
	Gl0lqBXZi36pUhnx/RhxDCsG09wP28eg=
X-Gm-Gg: ATEYQzxH208rbp/LmV0azevhi3HV2+8KMGvXeyIK9DcC3t5fOaKopp2sx72p1qIoqds
	OpBD8xYLo1/xbLiC8w6HHLhMbxq1fPdqaW4xZYAtt04zmygx9BqgbUyAgEqeP5pnLhQGXMY/eeh
	jKTM/bRq8yU+RdCdwPKQrgMYNxzlWI1xjiDAW/w0lDeQRyL1Q2E/3Wrl012gcb8M9DjzLRQ5l3+
	y8USWfmMQ7q1fT+bLtQmnGbbSfEbqZ3l8jNLjYfvIM6sqRQOdeHXNHNnG1anqhy/NXF78VxBjh6
	Tu08e2qv4aidYCwh+03dZQsZGbYjZP+NZdJrWJc=
X-Received: by 2002:a05:6402:270a:b0:66a:3419:248a with SMTP id
 4fb4d7f45d1cf-66a34192961mr1158702a12.13.1774326482054; Mon, 23 Mar 2026
 21:28:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260225010853.15916-1-ericterminal@gmail.com>
 <20260225033840.33000-1-ericterminal@gmail.com> <aaRbWCeu-wNdWGzB@horms.kernel.org>
 <CAKNPVZA2sFv7k=wyf5iBGyOUQcHkAdpVLVNjuqr+7XBXDKxNbg@mail.gmail.com>
In-Reply-To: <CAKNPVZA2sFv7k=wyf5iBGyOUQcHkAdpVLVNjuqr+7XBXDKxNbg@mail.gmail.com>
From: Eric_Terminal <ericterminal@gmail.com>
Date: Tue, 24 Mar 2026 12:27:50 +0800
X-Gm-Features: AQROBzBgTmKHaA7x9bBR6YuiaU8Gh2HBa_zkliE59q0Q7S-SffyKp90n7TFmYBI
Message-ID: <CAKNPVZAtH59NRqDscaBPgFYhxOB=KzTY=Y+FA9WBkDo_um33tQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] net: replace deprecated simple_strto* parsers with kstrto*
To: Simon Horman <horms@kernel.org>
Cc: Dominique Martinet <asmadeus@codewreck.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	v9fs@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux.dev, 
	Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon and maintainers,

Just a gentle ping on this patch series.

Following up on my previous email regarding the testing methodology
(using virtme-ng, verifying the Oops fix in Patch 1, and confirming
the strictness of strsep + kstrtouint).

Does the provided testing information address the concerns? Please let
me know if there's anything else I should clarify, or if a v3 is
needed to move this forward.

Thanks,
Yufan

On Wed, Mar 4, 2026 at 11:28=E2=80=AFPM Eric_Terminal <ericterminal@gmail.c=
om> wrote:
>
> On Sun, Mar 1, 2026 at 11:29=E2=80=AFPM Simon Horman <horms@kernel.org> w=
rote:
> > Hi,
> >
> > Thanks for your patches.
> >
> > I would like to understand what testing has been performed on these pat=
ches.
> >
> > With the possible exception of patch 3/4, I feel that unless they
> > are motivated as bug fixes, these changes are too complex to accept
> > without testing. Although the opinions of the relevant maintainers
> > may differ.
> >
> > And as for 3/4, I lean towards falling into the policy regarding
> > clean-ups not being generally accepted unless it is part of other work.
>
> Hi,
>
> Thanks for the feedback. I've verified the series using virtme-ng and
> a userspace mock harness (for the 9p tokenizing logic).
>
> Regarding Patch 1: This is primarily a stability fix. I've tested the
> error paths by forcing init failures on a non-Xen system; dmesg
> confirms the new sentinel-based cleanup (NULL-ing intf/data and
> checking INVALID_GRANT_REF) correctly prevents double-frees and Oops
> during teardown.
>
> Regarding the "complexity" in Patch 2: The strsep + kstrtouint
> approach was chosen for strictness. I've verified it handles cases
> like "1,,2" (empty tokens) and "1abc" (malformed input) correctly. The
> latter is now rejected with -EINVAL, whereas simple_strto* would have
> silently accepted partial values.
>
> The same applies to Patches 3 and 4. The migration to kstrto* ensures
> that sysfs/procfs interfaces now properly validate the entire input
> string.
>
> P.S. I used a translation tool for the message above, so please excuse
> any awkward wording.
>
> Thanks,
