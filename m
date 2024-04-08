Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D27F79C2
	for <v9fs@lists.linux.dev>; Mon,  8 Apr 2024 02:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712542996; cv=none; b=ZXzLNOIXmN4KBiI5MfdlMNbQh2+cTbc/R0ED6SaQzSa+A8AJ+oixDyKvSfCw9A1YI6L00l/gbZMsYJoRkqQ0J3/LiyXR5Nn7MVHiyQckHYvWpa48nQXOsoYkrKwP/2DlP14X6IzgoWHTaGggnLJ6EibAev54C+zVp66FltRABIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712542996; c=relaxed/simple;
	bh=0wqGYpHM+QRRQ+LTIiNbGK8l4cyNAeD0tXLxx0gF8pc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pYzJtiYYJoGW/WUWiGe/Lb8SqEfdDGT41FUnXXUj8he8PC0Fat92hPB1BU6YjD/cpgTmU+4HMp7ahsnHo4Af3DSl1ry1nrtigIxt1ZMeBKpwT2wiBmtnol1U6ntNndAMS0q3UcvFDz+IFu1kyxg767WmAKoOJhv3Au+mrt4WbNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EjwFZwM0; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EjwFZwM0"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712542992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0wqGYpHM+QRRQ+LTIiNbGK8l4cyNAeD0tXLxx0gF8pc=;
	b=EjwFZwM0Dv284/ILO3YtcLMy94JxXvNZ62Z91FzIpbBn4hLIWqsLNbV60b6R0OkREW5l4p
	553B39dNn2PpR0+CnAubqXVdtbRHg5+LTtsU8FSbbKMQ7H+U8JlIh9DPr/zdwPGBWedt19
	T0nz/4IIztacawvouSWFZqLnLACPsPU=
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: ftruncate fails
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
In-Reply-To: <A9C784B0-3B04-4EBF-8AFF-DD5088B5EF67@linux.dev>
Date: Mon, 8 Apr 2024 11:22:56 +0900
Cc: v9fs@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <74C91BF3-4BC7-46A7-9BB2-1360E07B6FE5@linux.dev>
References: <E7D462A2-EE93-4A57-9F15-8565EE1567F3@linux.dev>
 <ZhNP4SISzZOGwy4A@codewreck.org>
 <A9C784B0-3B04-4EBF-8AFF-DD5088B5EF67@linux.dev>
To: Dominique Martinet <asmadeus@codewreck.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 8, 2024, at 11:08, Itaru Kitayama <itaru.kitayama@linux.dev> =
wrote:
>=20
> Hi,
>=20
>> On Apr 8, 2024, at 11:01, Dominique Martinet <asmadeus@codewreck.org> =
wrote:
>>=20
>> Itaru Kitayama wrote on Mon, Apr 08, 2024 at 10:44:51AM +0900:
>>> With a recent kernel I see below program fails (Bus error) if =
executed
>>> from 9p mounted directory, not with the local filesystem (Ext4).
>>=20
>> I cannot reproduce on 6.8/6.9-rc2 with qemu and a couple of options.
>> Bus error would be some problem with the mmap of the executable given
>> this code? so probably doesn't have anything to do with the content =
of
>> the program itself...
>>=20
>> A few questions:
>> - What exact kernel are you running? (or closest approximation)
>=20
> v6.9-rc3
>=20
>> - What server? (assuming qemu) what mount option? (tried default
>> cacheless and cache=3Dloose)
>=20
> FVP and just mount -t 9p FM /mnt
>=20
>> - Does this reproduce right after boot/mounting the 9p filesystem?
>=20
> Not immediately after the boot/mounting.

My reproducer wasn=E2=80=99t explaining what a kselftests was showing.

If you build the =E2=80=9Cmm=E2=80=9D subsystem and execute one of the =
programs, gup_longterm from the 9p mounted directory, you=E2=80=99ll =
notice the ftruncate error.

Thanks,
Itaru.

>=20
> Thanks,
> Itaru.
>=20
>>=20
>> Thanks
>> --=20
>> Dominique Martinet | Asmadeus


