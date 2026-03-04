Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A684C33B96C
	for <v9fs@lists.linux.dev>; Wed,  4 Mar 2026 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638136; cv=pass; b=Ho2PRDn8UJhiTKkEWSYrohHkbM4y/Txxa8GmFBlaPMP/NvdUUfPq9Cq79KGOfeqXXtm/CIxQzAB/j3et5FrrX7G3MNoRzc9sQv9xUdA4z1OzhK0HLL5VehSUvg/BooD0kltyZ4WNyycT8aJJBH5xm1oi7yGqgoKgpZvjvatoeBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638136; c=relaxed/simple;
	bh=QXgnaupTOR4EHZcvNrR8+mOFrNjx7Wk4vmJzGUnHFLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GiLlSaAfwokZ+ZxPavnqaWzaOGGamg+z05fNNcGAwfBU7RBIFrc31pTW4xe54JTTezio5cGq3vU4A++H174N/35K1X3e59B0+ON5OiUbbUatPpnrYUD3bJ4WHOaPaEZhwI35DOe3gHm8kJ3+pHwhm5Efb4++io7umHwa7AhqXqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wk6lWoyH; arc=pass smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wk6lWoyH"
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-6611e4aefdcso755230a12.3
        for <v9fs@lists.linux.dev>; Wed, 04 Mar 2026 07:28:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772638134; cv=none;
        d=google.com; s=arc-20240605;
        b=Jy/Fsfg7MM1u98EoxMD5yA27k4giXD0/YQIQtD9ajtNgy17PFK4PkQbo3KBW7+L5Mx
         ZUiUpfbncgJY6IGSQiVCD2zlESwENSd/vArbl2rnysB0z7F6MdApyufflsfVWm7OzLxa
         ATgKqnsxRs14RAPOU1McOsaa2vSM29sysmRKpR3RQ0LiyRw32//e4amm5z4S1qFCe+D/
         XcI9WQjMq0wANwqe5IH2J6e9o0KFPVs2+hKQzgvlvswwEx4QfPrLF8biE2nKTCj7EFPk
         sGDfPKaqQxkjQtOTSxsxDmPHRBezyioCdShHo2V90LbE9aDmBAZht2Wiw5mLEIKaxHk1
         0maw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QXgnaupTOR4EHZcvNrR8+mOFrNjx7Wk4vmJzGUnHFLY=;
        fh=xikTGdZlSILXk0ZgRy+QAKHop9tmCql3aLU4IWGYFno=;
        b=VPVIF2bMWOSKMUl3rS1H1uZVRc6jDmKhtVvs4ND9bLn2TDJ/5I21cqe/cUrep7WOGz
         V/747XPz0fZDQfYTTK/5ODTkRfQLvWb1qUHhOaYDUcqDJahpk725xUBShkldLo3bcVJc
         m85YRM/twGptfICoKpW5yjoL430tsybkp0A8UGxoYkhnvmv67dJHQuZVwawbCyY7V9ki
         Se6mZyNLW8RpRJqSHAngzgrU9sNXgnr13KzNqaLeyE9lrYXhhlSrOxMj4HG+tBJZpbiG
         FxtR/GXB7RcPjvev8vlCnrfB34yvK/PBkbXELZOEhfuBNZ5WvDWGpTBuiN1SsRHoDQ1R
         O7ng==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772638134; x=1773242934; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXgnaupTOR4EHZcvNrR8+mOFrNjx7Wk4vmJzGUnHFLY=;
        b=Wk6lWoyHsyys0BDroyPd/wfz6DBkfKrwGKQXzELBG6p1gtHCwKj+QNNkWJi1iR2AnV
         rUsDq/39Q07eRTKryMsILumOqlRrCbnyT3+eTTHlboeZ15iTm496kE/AOqCt+cNxtQff
         itZyn5WcM7tksASY73u1waUET8r+nYvA7L8ZkkraKLI6HBcCAhn8WIUsWPrWBtt2Hg0s
         0tV+15a5Fdvha2rEyfrgz8Ws+nguX6Hn00WCFDskrXrCIRfrWi6CCPcWGGEdAMNmIRLw
         QwxEJq3r1FGdXLf7WtaGVhNYO8WvFKTUuqqn7uOCwJDQpYlbQIqK7oKNIn25/NMvDFFE
         Q+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772638134; x=1773242934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QXgnaupTOR4EHZcvNrR8+mOFrNjx7Wk4vmJzGUnHFLY=;
        b=nIflD2kFN7VqPEnbPyR/aazVvHq4OsxRs8GWacq9X44wwRgOYEH+AwzjbS82yGv0Mw
         SzXUHAPdm9g2Og7oxDZ+qek8QKcvsoEKbrnM4BPwCnlFPctJ9mAynDEb37AyMO9GqHXr
         I6VWhZ+2RKrwD7+JZgeW96jQB4yysRuvy8x9a5COj5mo1Z+68sntQwLDZnu7ilApcGk2
         zehdXe4p0Hp4gy6J3bIu8iFNGnc57wqbz9ijsiFNWoewkJ5Dqi8PBmTV2Hg5ehOvF+Bl
         yaY6X/sJR6QCYNUARMmKgRfxgtlNXwWGk4g23ToycCSkkfKLw7lKAWmL/Qmn3Kjc/8fc
         n+6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/vJtLA3j0/vOZz5OHRwzYzH1HAnci90O/q/GGhfX4KDDmn/sPFOn+eelbeSySXsKrDfyp@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0ZpIBYSgH0iu+p66LupCWbsENd8JqPC2vkl1ci1VhmkHmQLHT
	QBs94N9DW+N0labUThF3+Ok6L1qFzycWqmUtxahQPkF4U5v2UgClK8warwNmy+zmRAIU1LlTSDt
	uc3+Nymt9qBGuUKiXemo2iWWZVF/FwDmW00s1oKjpfOK2
X-Gm-Gg: ATEYQzw1evtcwUUe167whM67ZGJam9Cnbj263zT9TdmLXq0xxY78C1dKWuYCK7/qmja
	IA10lcg7bb6YF8Sm3UIk95y8J+m/2bjj89xsKOn/Bt6rbeVMSBuM6IL7Tp7J/AaDSA3qp84p99G
	cnTVKbQz3KszFWkpnmhmPvGc7l9L61R4Vqhw1kGGOQBKHMWX+02x0bhagpr+6oWPABNkeRPCoOK
	3tC4cCUoTLaEaahYCqKs6NZIZs5BfooIjwi1qCt9OO7CMjbaM718fDgLjF6uqSbQ0Tj+hMIsKyL
	3p+wSxzS0xe6YM3nOvvqYO61ylTu8/dYdN/+c7ia
X-Received: by 2002:a17:906:fe07:b0:b93:edc0:e2e8 with SMTP id
 a640c23a62f3a-b93f159439fmr173698266b.48.1772638133729; Wed, 04 Mar 2026
 07:28:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260225010853.15916-1-ericterminal@gmail.com>
 <20260225033840.33000-1-ericterminal@gmail.com> <aaRbWCeu-wNdWGzB@horms.kernel.org>
In-Reply-To: <aaRbWCeu-wNdWGzB@horms.kernel.org>
From: Eric_Terminal <ericterminal@gmail.com>
Date: Wed, 4 Mar 2026 23:28:42 +0800
X-Gm-Features: AaiRm53HxF5F9P5qVnAjApnPFfDhasNN9x-M6tagR-mOrAogX8sxQv-oIasNUdM
Message-ID: <CAKNPVZA2sFv7k=wyf5iBGyOUQcHkAdpVLVNjuqr+7XBXDKxNbg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] net: replace deprecated simple_strto* parsers with kstrto*
To: Simon Horman <horms@kernel.org>
Cc: Dominique Martinet <asmadeus@codewreck.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	v9fs@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux.dev, 
	Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 1, 2026 at 11:29=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
> Hi,
>
> Thanks for your patches.
>
> I would like to understand what testing has been performed on these patch=
es.
>
> With the possible exception of patch 3/4, I feel that unless they
> are motivated as bug fixes, these changes are too complex to accept
> without testing. Although the opinions of the relevant maintainers
> may differ.
>
> And as for 3/4, I lean towards falling into the policy regarding
> clean-ups not being generally accepted unless it is part of other work.

Hi,

Thanks for the feedback. I've verified the series using virtme-ng and
a userspace mock harness (for the 9p tokenizing logic).

Regarding Patch 1: This is primarily a stability fix. I've tested the
error paths by forcing init failures on a non-Xen system; dmesg
confirms the new sentinel-based cleanup (NULL-ing intf/data and
checking INVALID_GRANT_REF) correctly prevents double-frees and Oops
during teardown.

Regarding the "complexity" in Patch 2: The strsep + kstrtouint
approach was chosen for strictness. I've verified it handles cases
like "1,,2" (empty tokens) and "1abc" (malformed input) correctly. The
latter is now rejected with -EINVAL, whereas simple_strto* would have
silently accepted partial values.

The same applies to Patches 3 and 4. The migration to kstrto* ensures
that sysfs/procfs interfaces now properly validate the entire input
string.

P.S. I used a translation tool for the message above, so please excuse
any awkward wording.

Thanks,
