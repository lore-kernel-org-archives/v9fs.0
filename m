Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7677815A8
	for <v9fs@lists.linux.dev>; Mon,  8 Apr 2024 02:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712542149; cv=none; b=Gc883KDYIQ+v9hI0ZdHDFiwA4hBFGNCR4fGyBVWoXxeMD9XJ1aht1dAZGuvdoo5OzzCvTEXH5IrfbczISYNqT3Rb+oP+ja+qAT7bx3vZAWYdto4DyWJpm7qGfTfS5fbw+z7XdgDOr7HMLzYruhCX+fLJVPxDkZveIWgenQV3AEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712542149; c=relaxed/simple;
	bh=R4DbXpB+J7oraiSorFBauK1+MV/t/l3J3kpF9uhHQ3U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TKIiZP9n6p5nElLzSkfVhOh1QaHmi5kzEFuXx37ygZVoFYK5cCNAsANmqNKZDFGXmlbR/4zBpf7iWSEL78WkMao9EJDUbMPg7fm6VoqFUgvsVSgWlI2q2aLwZ5yYh1T/oYh+mjj+420xGfGaotAe4BkBm6v3gu0iW9eiap9tpLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I1geBa14; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I1geBa14"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712542145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R4DbXpB+J7oraiSorFBauK1+MV/t/l3J3kpF9uhHQ3U=;
	b=I1geBa14P/H5Gao9fweb2osSI6YBFj1ImyF752wwEwOXEEuZyWQmf2SbblJrO4RMTfyfZk
	WuRdicB7bARdqq3VL7Dsa2moYS8NuUlWztal0JJJCk76Zt+IEI5Aspt0pV76Qr9dtasU5B
	T6PSoue4gfIhQvAVC6vlAZ56zCIg4qQ=
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: ftruncate fails
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
In-Reply-To: <ZhNP4SISzZOGwy4A@codewreck.org>
Date: Mon, 8 Apr 2024 11:08:47 +0900
Cc: v9fs@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <A9C784B0-3B04-4EBF-8AFF-DD5088B5EF67@linux.dev>
References: <E7D462A2-EE93-4A57-9F15-8565EE1567F3@linux.dev>
 <ZhNP4SISzZOGwy4A@codewreck.org>
To: Dominique Martinet <asmadeus@codewreck.org>
X-Migadu-Flow: FLOW_OUT

Hi,

> On Apr 8, 2024, at 11:01, Dominique Martinet <asmadeus@codewreck.org> =
wrote:
>=20
> Itaru Kitayama wrote on Mon, Apr 08, 2024 at 10:44:51AM +0900:
>> With a recent kernel I see below program fails (Bus error) if =
executed
>> from 9p mounted directory, not with the local filesystem (Ext4).
>=20
> I cannot reproduce on 6.8/6.9-rc2 with qemu and a couple of options.
> Bus error would be some problem with the mmap of the executable given
> this code? so probably doesn't have anything to do with the content of
> the program itself...
>=20
> A few questions:
> - What exact kernel are you running? (or closest approximation)

v6.9-rc3

> - What server? (assuming qemu) what mount option? (tried default
> cacheless and cache=3Dloose)

FVP and just mount -t 9p FM /mnt

> - Does this reproduce right after boot/mounting the 9p filesystem?

Not immediately after the boot/mounting.

Thanks,
Itaru.

>=20
> Thanks
> --=20
> Dominique Martinet | Asmadeus

