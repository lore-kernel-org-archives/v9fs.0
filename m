Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719713ED3AC
	for <v9fs@lists.linux.dev>; Tue, 19 May 2026 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198833; cv=pass; b=ixZ0qcSbD6d0bP1eu63FK82YOxERJD166GOCkNOrt2C3mZ3z4w+WHJmEAY3y/4RTX/3dz9NAn0c8u1z3oiSggr6Ndv+YDQ2gAGHKa3mN3iF1afokwTrAcCXQTZ/Aaz0R52ldDKk6R+SO8Dt4MNoqhQhfoA8wYVoH2FmhDnZ4xy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198833; c=relaxed/simple;
	bh=QJ4KJ/g3fInpA9dxwtg4On7IOQL0oq1w0hyYLSGGBq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AidrWOk7Ly4QYV8FJhNoZlllWfeCIurRekH99R3f/XHHuG8VNTo5QU3mHC6fz/bLZmdMspqfmCRjqUKqxuJuOfn/AygSQ0h6izvGM97/aqzHCBoe1dL8Q947v5My7uNlgI4M+8y7tSqdJjgMy2xk4JcM/B8d1h4AuWAcFesM72c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3qXy0rX; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3qXy0rX"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45d96d21e82so2118711f8f.0
        for <v9fs@lists.linux.dev>; Tue, 19 May 2026 06:53:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779198829; cv=none;
        d=google.com; s=arc-20240605;
        b=IpmC1twa2Ze/H1QpaRboMULfOvvxB3jBiyTyrbiVSKbe4SKDJwSd3wSznUzOTi76zd
         w8AzDzU1DYEnuewZ08hF2JTg7LcRL9w/5a9JwIL7QfpIJghnaly7RFBhOAZ+4NoURQl6
         89FbdtGAlZzC7cGLVqPMvp3oB45NPslkF/Z6LK/z71SBR5ESPyg8dA53coWHw90Nq/cT
         K04WexmFRVRl366kjJSM4SONcDowH2riSwO/ucA2CljercLelWRVifLfox4UVqlvtLt8
         7ESQknwZkRDeWvsAlqOqUXFuU5WcX6W6NU3nuYalmTWj+jNLDPVAuAvui+1GxieTk/iS
         d0pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=n1LQyxnpPi+Z+D/FQN9BLFSwJyyBjmHjXirs065b7UU=;
        fh=zROF+UN7UbQYXKg8uTEnFlxUVHea5wswon5K3A5k9Ok=;
        b=kVe6AxnWiR7mHlogPR017RtNXhmEQteBMj9sXN+AiPjaUsmUfWUIKf7v0eVGIxiSZo
         Mt+98hljfK3uSV355+Mvk10b1IpDcwGhJH4SQR1yFtJ0POpSFp3DLBG35O5i2/Sie0x5
         bMyyckkGm2uoJ8PT1zEOVRJL/8iFmtu8TC3S02y6HKEsPJ9IlC3WmbmEqczNkBxmq2Nx
         /+HNtQM7+834tcGlsZcdsULt1TiSKcCwqMojzE0wts7Oe0IKN21SuwgLfi/LBOTLwRuD
         TTX2FyOig0+FwN8eLy8qVLPALuj3snZxXdS69QL9n59PSd4wcp70jKZjesNcS4RjyEz9
         lHUw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779198829; x=1779803629; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n1LQyxnpPi+Z+D/FQN9BLFSwJyyBjmHjXirs065b7UU=;
        b=A3qXy0rX9P9tjqsf9hCxqqW9YcKlSqQbVowlz43y7Reay3MuYj/qA3U8RIRrLKTNkC
         hGrC/g53KQJHAVApi639mxP3JMzDxWDw+PwuOpDFlr8oyl72hfD7p5LSeaniYICqgBMs
         +PA6dPAWtcGX3nHzcBA4cvj8T+BJKnnXRiNlXTG3Fv7iWE99RKoNa0wcYnTipUbKo/5P
         gCAGyJFMPSC7hnahhV95L5huMCOPxNWrKvwSSWeOnVUs2xXJNdNge69I4bCDtvtQhjol
         o7yAhJTf2YAFcQtqZViAbLtxGNP0t+sFKd/fUDh2RtQPQ3+HnNizUZ8jj7giItMf+zw8
         VaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198829; x=1779803629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1LQyxnpPi+Z+D/FQN9BLFSwJyyBjmHjXirs065b7UU=;
        b=Pe5/7qNGPFYXVmYMwAOlYm59lVOoGEEn/w69Qt2EzOMcSL57G9U9v9ildPAoq5eNFx
         qvzohQgf7yQHKN+hmI8fYV0bD1xyfLyjrYQ9Q0/wKQQS+qFcqvyOGTB505L4Dor175aR
         phQpWj816gRW9369hbKJexVMR/frXHnRW37PiBd4cr2PsVafokJDNt/yAfZZ8giHKcBN
         uNZXaaXMdB/tc9Ws0kr1fOdCUlVvJwYdQctm5MzY2F++iN9Ho13Rm0wrQWWNvXCxVtdx
         HxXKiJlgik7wExG+RT9bL4FiFWmSkVYLb7HEAcaaRwOvB6Lxj+HcoOPGNW5JBIro8X6b
         E3DA==
X-Forwarded-Encrypted: i=1; AFNElJ+UpgLc6oHgk3rtm93FhD4R6aNuErI4ss+BbDf8rgOtuN8ZVaPFCDxrS7oDbTwHYprOV1wk@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9W8omqZa7q1WNf58s5dxHSrls/C/Z9dRbR3l/xcRfBtMvMnrC
	y29birqofo7wsJ9SXTNzqKjaieXewuc9ZdmQkQDTit/CgDESmgrZ8FDE0MuDiTKQXona1YUGYOZ
	Y6jMgsGqCaUshpd1iuOLb/ftqWC3PbVc=
X-Gm-Gg: Acq92OF/UupdyKg+nupb9rolKYpo5LQy7EIGlD1Lcca3/XJtncMOmdXRvPKECzNmVZE
	ZEIBIMJzMFj5Iooed6lOVwbfT6qDlduiRUCKKDPSJw4vY+OK8mjTABrPlC4G6ztcRBds/tVDX7O
	3tswSn2FmiIf8Y1q0nQLy1+qfEHjqwPpTpuea7ixTLGXejwqX8R0uVpAHvw/R0KqGlzKoOW0mSF
	mQkJZf55Kty206FNmnPJwJIaVWKjHokVn+BLTN4aaJLhcN16Uwd21Hbvu0vT+vs9E6iPYJ1b0fJ
	l9iStbDo4LKJOVlwPoJh
X-Received: by 2002:a5d:5d0d:0:b0:43c:f583:126a with SMTP id
 ffacd0b85a97d-45e5c5a0cf8mr32574801f8f.14.1779198828486; Tue, 19 May 2026
 06:53:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260510182856.17569-1-aayushpatilsch@gmail.com>
 <agxW8An7fRApCY1r@codewreck.org> <CABc3pKGKCLydod2NOgETP-z0T5BHep8hyy7z2UF3o+DrWEh5yw@mail.gmail.com>
In-Reply-To: <CABc3pKGKCLydod2NOgETP-z0T5BHep8hyy7z2UF3o+DrWEh5yw@mail.gmail.com>
From: Aayush Patil <aayushpatilsch@gmail.com>
Date: Tue, 19 May 2026 19:23:38 +0530
X-Gm-Features: AVHnY4JUcQHxE5CA2_Z-v_KfhWRQX-KRwhVLbvEnNr1BdXF7V1KcN6mL2SfXxH8
Message-ID: <CABc3pKEY8QvQzWPeU9QGBFG1dtGSdseTRdXF_5MUX1MeNBV5QQ@mail.gmail.com>
Subject: Re: [PATCH] docs/filesystems/9p: fix broken external links
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com, 
	corbet@lwn.net, skhan@linuxfoundation.org, v9fs@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dominique,

Thanks for the review! Yes, the trailing S is a typo.

Regarding the replacement links, should I include them in v2 or leave
those entries removed since you're not sure if they're the same files?
Happy to go either way.

Aayush


On Tue, 19 May 2026 at 19:14, Aayush Patil <aayushpatilsch@gmail.com> wrote:
>
> Hi Dominique,
>
> Thanks for the review!
>
> Regarding the replacement links, should I include them in v2 or leave those entries removed since you're not sure if they're the same files? Happy to go either way.
>
> Aayush
>
>
> On Tue, 19 May 2026 at 17:56, Dominique Martinet <asmadeus@codewreck.org> wrote:
>>
>> Aayush Patil wrote on Sun, May 10, 2026 at 11:58:56PM +0530:
>> > The xcpu.org links for xcpu-talk, kvmfs, and cellfs-talk are dead
>> > with no archived snapshots available on the Wayback Machine, so
>> > remove them. The PROSE I/O link redirects to a dead server; replace
>> > it with an archived version from web.archive.org.S
>>
>> (I assume the final S is a typo here)
>>
>> Eric, it looks like you're the one who added these links, would you
>> happen to have a copy around if you care about keeping these?
>> Otherwise I'm not sure of the value of listing the papers without the
>> actual files available, but I don't mind either way.
>>
>> I agree dead links are of little value though so will pick this up if
>> there's no reply in a while
>>
>> >
>> > Signed-off-by: Aayush Patil <aayushpatilsch@gmail.com>
>> > ---
>> >  Documentation/filesystems/9p.rst | 5 +----
>> >  1 file changed, 1 insertion(+), 4 deletions(-)
>> >
>> > diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
>> > index be3504ca034a..65809a1dad21 100644
>> > --- a/Documentation/filesystems/9p.rst
>> > +++ b/Documentation/filesystems/9p.rst
>> > @@ -23,13 +23,10 @@ the 9p client is available in the form of a USENIX paper:
>> >  Other applications are described in the following papers:
>> >
>> >       * XCPU & Clustering
>> > -       http://xcpu.org/papers/xcpu-talk.pdf
>>
>> I found http://mirtchovski.postnix.pw/p9/xcpu-talk.pdf but I'm not sure
>> if it's the same file
>>
>> >       * KVMFS: control file system for KVM
>> > -       http://xcpu.org/papers/kvmfs.pdf
>>
>> Looks close but perhaps not the same as
>> https://www.kernel.org/doc/ols/2007/ols2007v2-pages-59-64.pdf ?
>>
>> >       * CellFS: A New Programming Model for the Cell BE
>> > -       http://xcpu.org/papers/cellfs-talk.pdf
>>
>> Couldn't find anything fo this one
>>
>> >       * PROSE I/O: Using 9p to enable Application Partitions
>> > -       http://plan9.escet.urjc.es/iwp9/cready/PROSE_iwp9_2006.pdf
>> > +       http://web.archive.org/web/20110101152020/http://plan9.escet.urjc.es/iwp9/cready/PROSE_iwp9_2006.pdf
>> >       * VirtFS: A Virtualization Aware File System pass-through
>> >         https://kernel.org/doc/ols/2010/ols2010-pages-109-120.pdf
>> >
>>
>> --
>> Dominique Martinet | Asmadeus
