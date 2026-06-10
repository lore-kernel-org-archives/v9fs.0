Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7334E3ED5AE
	for <v9fs@lists.linux.dev>; Wed, 10 Jun 2026 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781107264; cv=pass; b=ayBUu4VljvFm7dplHB2gwFQ0W5uV4O0Cgd2Ix1cpsxqSVAVlTJsXZWNMcG5p3S8Z3kibhMJKbSjff75X2pMwJBTeB040zIBtkZfVdbZ3/Sp2N2bWaH86mfXXH2S31+xBR60ItYWmwB7g5sbBZwFy4XJoj6/hyEQGEryo6pMwRoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781107264; c=relaxed/simple;
	bh=bB3xA/MHCU+PelFiFJxUbLWzHMG3lJQds9/bzXf05H8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plGnXbpJa9u7n4RDoCeOAA6Gn95RVocmQrRkfHuyETAkuiFtCT4ff5GPvU4KIcoLv8EntVO2v7tYUVLbVcOK4js8iQ3JcaeLyAvDR2lpJgAYkFNzTfOLQLaPXL5XFYums1uZX9wZGAhdU1tqJEFWUpg/NjPuWBfj8zJhw9dh54k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYb5UzX7; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYb5UzX7"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-660456349d9so6742489d50.3
        for <v9fs@lists.linux.dev>; Wed, 10 Jun 2026 09:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781107262; cv=none;
        d=google.com; s=arc-20240605;
        b=Hdbaz+eXUnWRgd9dJgVSN1GS24cWtDpFEyaY9aLip6fD4BygchQVU5+Vg3t5r9WsxD
         OQKnl9Y9viqDMFOtL9gy+BchQls1JNk2CKAlAFnuSQjfeIXcimrLJ5bdJCZuurY1YNRX
         gkY0xZA+gbZn8QQu17BZr75Tn8+8l0/9HWre0EmHX7qeG3WJlCwWdkKEHVvabEs3uslY
         rZQ6IrJPDqVczUjh6zeie+xeCdwESVMBQ+fixquYShxm/YDXU3xbosSC5xhTqzus/QZj
         6Jeea978eKSe/BZpM1WI1cbSsKCfvU9xSX9XANviZDMD6Bn5WhU8tNguekkwWPDp2lB3
         e/pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bB3xA/MHCU+PelFiFJxUbLWzHMG3lJQds9/bzXf05H8=;
        fh=y5nFYLrFUnVX1UIUIGdMbH6Sd6WyEpc8KRUgwVdWZqc=;
        b=YtLgOslstGQvQ8LXM2VbK0FBVikSOGfxMqFHXZeNam0jyqv4LxBI1lccMevdLkzMyd
         guhr6r2rv7+h29tln7zDyyJ/s0Wf1TfnoSBh/u93Jf2yIGMANix0Fk8rj0tcOHc9k3kj
         QYrRD9Ywnr1gbYY9YE5e9H2R9Ykz+pF4AnL0hDHQJjCILeqYIbxD10dTAazMoCB4zem7
         8vp/U24IYALvPtGsvfsS7THlgUehkn+L2HD/opBSMuGFF1SIeIM3Ow7bbxFbGhEpb4fa
         aJ7uX77WZd1Or95OfZ9xxrLp+C4+8TzHxuROw/gPlQpRx1I1rIRBWOJ8GlEwuRrL4MJ5
         LemQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781107262; x=1781712062; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bB3xA/MHCU+PelFiFJxUbLWzHMG3lJQds9/bzXf05H8=;
        b=IYb5UzX7q0BK6U/MUM8CDgQ1bQh7oVeQ5xP0sXpYoCayD8pBY+HuPTvEl9OyXIZG0n
         Rvn7DyPEkmCsGLjyocAB88msP0b8+99jzaWBgC1KC9L+paljPYs9tgevMWDZj5FSxD9E
         Ok8QpWzaeNFiom3cbTbNOc8Onl1PSffrTeCd0bvuAt1vs/nmFgwCczAT7gxbqSHVb3W4
         5g5u2P4wX6i72bE2L9OOtk8DY6W6JS7VDNdsFYvlBb5FngDIOc/FLjpI8BbvgNmxeWDB
         BK+PDXMfaonFBUV5oQCUPNNNnUowBdUvDhkLlJvuQ6boAo5ZTcTobRApwFdDdbds80a1
         Z6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781107262; x=1781712062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bB3xA/MHCU+PelFiFJxUbLWzHMG3lJQds9/bzXf05H8=;
        b=a41917LM3yWvX7hYrGswCYLLDlhPUHJ8DEJ2UQsyQ+beYGw8nebdjuBKkIW4XrMluq
         2twwKAri2vq3BYlM0FClqJEeekYnS7cOF4YYIYBRDQX4YWbZB0HxmFe7qOITk4aVGLC9
         rM1b0hRAxlU7qGYMLIHWUUCVFWblFYFfjI80Gkk0g7uDGY1DUaamokUWQP8kgOq+fvNm
         5Hl7XGzMaL06oAagHuq3Zfob6l+wCx7KjdB+tnQVPa5076yJf1QIvLzqAceyXgB42aGz
         M59+Ceh8EFTHZ6V0IGbi+R0IQj+QG8bUKX1kdHn2KZS1vh3dr967yxuVsRwBVQezvXfB
         NfXA==
X-Forwarded-Encrypted: i=1; AFNElJ9mr6DJGPPKX6jfjx6b012UN4mkWpW0aADUbIbkMGp01/zJ9bGegJTh4YAvgfXkVGUL51PJ@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5UubBM75hMhxP6x1XXFz+20zDEN1He85PF45nDDZpz8Fekcc3
	brFLcFJgl1vPF0xcTJP+47NiHEW3S/zZeZJYp3UdSa9+7xfVs59aZtNe+/xTAOm6OrlqanuIEhX
	KztwYNHw7qsUYgHdnWU6Rv/T/Ki22TSU=
X-Gm-Gg: Acq92OHT9bS7yNr5ncaLUVS3Roezbo3ktLzmx2zbM2/EotpLm4bqF0uheFW47DahIAH
	GX236fi2pd4jS/M9rFBhMRHCJ+3HdIdzegDDn/8wMsIMXWUS5a8xkkSA871WSc1MC/Y+wZ6vNRF
	RfnHaCk7fDvpzXAK5q7FtVHg71Bsu1QqoZjR+9KuhND6x8CxS5dHbE4CY2oE9OMmyfTEwyYm6Ng
	lUtFPN6XBs333TS36U1hzYmbSLYYPnfArcW0MPBlOn9GtjPA0quVsDjV19fB86WkV2V4i92zP2U
	j7bm0wjvXnpdSwqrw98Ppt2FORMuNpjoFz0ozIBkHy7DwKk=
X-Received: by 2002:a53:d845:0:b0:660:56ee:ec03 with SMTP id
 956f58d0204a3-66106e5b480mr18896264d50.21.1781107261714; Wed, 10 Jun 2026
 09:01:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260610114206.3749904-1-michael.bommarito@gmail.com> <1962500.CQOukoFCf9@weasel>
In-Reply-To: <1962500.CQOukoFCf9@weasel>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 10 Jun 2026 12:00:50 -0400
X-Gm-Features: AVVi8CfE6Z8Gd2v7H8nISX8O4sfO8iVy30cFRa5xdFkX4tgN_Vkz1s3oigsZeEA
Message-ID: <CAJJ9bXz=01tvoUTF8cQ6rUiCbsyYQbGKTcXD7LwJSwBu6y=unw@mail.gmail.com>
Subject: Re: [PATCH] 9p/trans_virtio: bound mount_tag show copy to one page
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 11:46=E2=80=AFAM Christian Schoenebeck
<linux_oss@crudebyte.com> wrote:
> I would say no, a 64k tag is at least suspicious, if not even hostile.
>
> Therefore: what about simply rejecting the device at probe time if its ta=
g is
> beyond a certain length?

I think that's much cleaner if the user base really can't think of any
legitimate purpose here (or in userspace utils).

FWIW, on a similar Xen issue, we're also talking about blacklisting,
which is one step even further.

Thanks,
Mike
