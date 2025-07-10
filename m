Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A22D262FF5
	for <v9fs@lists.linux.dev>; Thu, 10 Jul 2025 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154901; cv=none; b=k3PPr8xVOkyWypv0SAkXiGQtptV7DNsKaaQn7CJoJY2s3ayAwiOOdleXmQMdTDqLUzPY3M6rtyHN/NLzPl25XP8Y7TDgXXiDhLYbWfBk2RbS0tbKsshAGspERBrOhQe7RR8Y/zJFuATn1qs2I3w9ZH8lhzkKdt9P5rDSS3KQV3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154901; c=relaxed/simple;
	bh=Y2cPTKyp8+pa4kvRMd2DbHQIqkwHAegaMbr/kZOwiA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eENW4UYTtAWu2ru+7eBymGdXej3dPXQCn4pu1ZAAomkOofq7DZJFPDhoV/7ENrREpV/6avb/KHr2lt9IFhS6lS3aZQPYgDDWJMaEMS+GkfpOIBdvLGqO0I6NCb3ChaRsNbTGeUzSSQrUKV/x0EZWytPeg4f8gwCe9ox0RT8uYgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=bA46aWvh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="bA46aWvh"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae3ec622d2fso163971166b.1
        for <v9fs@lists.linux.dev>; Thu, 10 Jul 2025 06:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1752154897; x=1752759697; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2cPTKyp8+pa4kvRMd2DbHQIqkwHAegaMbr/kZOwiA8=;
        b=bA46aWvhpdx+yglRnxdLtIHoAXdHQhGBDxM53qSkyA6ACV+dHtH3AuwhOTm9LTGyIW
         Ha2PQpZj8VYEiULc+LU9togjpdpp8kNtXOHjKDcJ8euYv3ChZHW3mLfFj+JyofRiC4et
         urTcE99TRq95nPP7RzWR9igxWos9Rhn+Eav40pkruzr0IF/M7o6xY4txgiYwQUC6w+xQ
         +F7Rf8zTi0u9pW5BHn+3/JbFAmg/MXKVi3CwhTlvdq6W2MmvvQjglWVphcCo9Fx+G8SF
         WETAfxAug21U5QQ2ZRU7CjOUqZKMV8FEOIf5CGZA0wFaY7DupLVklUFOKmF6CwIfhJJM
         sJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752154897; x=1752759697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2cPTKyp8+pa4kvRMd2DbHQIqkwHAegaMbr/kZOwiA8=;
        b=CveatRQx13b6vRylCsfjaYXw5u/yJ217sP/33glYP88D0Pt9tdg8swO/RGcoJRJOkH
         9mQJlbDCZ8XJ2DWqJFuw3OpcEEhyKum3D3jenXC/BApu3rez9i8XnhprBsn1Qyurs399
         FNbrmotF/s1jIe0RE34EnJl4jTNkGnkPW9lYPCKyZ74ibprrQdPRmCYfB/5r97QEaclE
         sFd1OXOztAThJakEgy2ttrlFPm2F/hQwhmqEM7C7iLMfygIYr/LglKjceF1nYS+rUM0X
         +5DtZHleCBuosYxkDTZyZ7mFIi+Qo9xiscXnOn8OGMjb4iG3d0FLb8nrc/kZscLesGQw
         psxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkHWzZHfC9XWAMMKwmoMdcxXjZJ1P6HKUXSZs6pRq6PXKx3w3dzJDEfk/zwyenzsJh+jaI@lists.linux.dev
X-Gm-Message-State: AOJu0YxLNjethilyJbb0aR2IfHeckS0V5D+n0CcZGS9faemVXf/zcf1G
	s7Ii1QdlVszLalw0VoxEJs+kbi7EMAeZAhcsXuoPdbxDCz0WDw8LTiPnbYmo2F5Ki4tTgTkVcNl
	m64ZMoo/JjSUKe4WBJAp6lzjVeUV17bHxkFelJyxldg==
X-Gm-Gg: ASbGncvoyF6QtRNK0In1bsAtDUuO7zGrGWxBRUBqgyTyUSuwLy87dLigUf69NKFS6+v
	wQa7kWAS3sg8dPKCaLph4FJ6MXLXRRO41CGnTyfx/u5imtl2QK0L2h0eyABea5VaGwyFIU3IKR7
	rSKkro2GnGiHDyeo4uCULjLhvKNmDHsBxVsDFzwDezaJevaLYrr3IBm+XJ7CaZ0ez5gbrv1hI=
X-Google-Smtp-Source: AGHT+IEUfIhpap/ErtxncROC/XukLmMNwnnCP5z2dolLnhei5TAHwMgshdrm44CHSjNOH/5s8BRS/dOJLaexhl9LvyA=
X-Received: by 2002:a17:907:d93:b0:ae3:6390:6ad3 with SMTP id
 a640c23a62f3a-ae6e6ea0035mr262408366b.22.1752154896676; Thu, 10 Jul 2025
 06:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250701163852.2171681-1-dhowells@redhat.com> <CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com>
 <2724318.1752066097@warthog.procyon.org.uk> <CAKPOu+_ZXJqftqFj6fZ=hErPMOuEEtjhnQ3pxMr9OAtu+sw=KQ@mail.gmail.com>
 <2738562.1752092552@warthog.procyon.org.uk> <CAKPOu+-qYtC0iFWv856JZinO-0E=SEoQ6pOLvc0bZfsbSakR8w@mail.gmail.com>
 <2807750.1752144428@warthog.procyon.org.uk>
In-Reply-To: <2807750.1752144428@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 10 Jul 2025 15:41:25 +0200
X-Gm-Features: Ac12FXzl_JlkX217YnsQK9NDpeOWbIXCejwCEnw4V1qbmZHn5mJ_E34Ih5jkMNQ
Message-ID: <CAKPOu+9TN4hza48+uT_9W5wEYhZGLc2F57xxKDiyhy=pay5XAw@mail.gmail.com>
Subject: Re: [PATCH 00/13] netfs, cifs: Fixes to retry-related code
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	Alex Markuze <amarkuze@redhat.com>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 12:47=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:
> I managed to reproduce it on my test machine with ceph + fscache.
>
> Does this fix the problem for you?

Yes! I can no longer reproduce my problem.
Thanks, David.
