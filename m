Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10FA1F5837
	for <v9fs@lists.linux.dev>; Thu, 24 Oct 2024 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729794323; cv=none; b=iK+Hh0W2IuvzEBHGvuzzhbBDFa/4SNIb9uSagOwgZtzOEwjtm+75r7+09KZMFXFVRSsZnSxHJknKK6moeHxqwpgJm7+XYsz6dd5zk4eQAfr7g0Q0iGPIfHf2ylGYao4cnxSE9Hkur5KbddqR2dmJwm00JE48wbuHMf1u2UwamWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729794323; c=relaxed/simple;
	bh=THOqL+d1TZl4PVDh3DxDVyzLnQklVdVLrwXBZ3sQwk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQ9Ikbe2mr8iS8vgM2R5HrckXGOrm01jsmN7iCE51lMovDNnz9mdLfyNeJqf0v6WYsQqT3UZH6mQA/lpuEp1kgmPP+ggZtEVr5i8qvaqlPKSqzZlXfizFocExsAm2WfHEtSK57e7QmVt8CqlK6NPESJD9EWbkOC9hWZ4rmNfGjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=buLXY9sg; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="buLXY9sg"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f58c68c5so2289118e87.3
        for <v9fs@lists.linux.dev>; Thu, 24 Oct 2024 11:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729794320; x=1730399120; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G2khBJsng+lMfA1RigqXF9i/RT/dqPLhoFo1OoVIZF4=;
        b=buLXY9sgtsxGM08QlW/2jB7HBW6QXgfR9jxwYuGIK3jUp2ouQhaerhtYkWS1NUFfk1
         4HCllX5zqd29cH8KK2oPuyeQYjvJ84AiX8ACSg0vCMfwrI4rL1QHzbqeznEe4UsG6AFX
         /Z2GDph4TQO9ON/Vd1xmzZiPf00sWBp9LH0v0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729794320; x=1730399120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2khBJsng+lMfA1RigqXF9i/RT/dqPLhoFo1OoVIZF4=;
        b=rJXsrSleBzoZpCTK5iyAIvO3Oqi/IXaqEK60vcVSUeuMnd/kuTOGaiwMrffzFCwZxr
         VxczCpmtil12+/tKC8JtMBosbGB0BYdCPhea1BfXUUIO/+1ZNoCRezxrezNIgO/SEatV
         5EHGWaFJY2RDOvIL5z7N1eZll6Z2XNV6kKaijBg8L2H8VqjjizhXv6rQMJ45n+p2e4vX
         imh45QBJNcDD30v7kJmgrP0cQchtiQQRL5dhi3f4pZW/c+3qH5sYFIjWhSscFXPXJqGL
         69S4fr5C4sWvO2ZYtZymLL/+TZmO/zNgRQFNN7TBEayzrLhqWAhtmDGKya+q9FJQqb18
         raSg==
X-Forwarded-Encrypted: i=1; AJvYcCW7gq+h+EBb7a+5m/5fGQZOlKgIVY9MGSHZU32v6A0hCPt458B+5IONBmoxJpsv40sgy6GO@lists.linux.dev
X-Gm-Message-State: AOJu0YyZkaFMxNiCrJOXuGbrZQ2IOxcOKf9fGWlqi8lwu0VUv36iXeMc
	lcc0IyXhToDnDgT+aqgWDEmv301AzNTCm4lvs6oh27F19gH6iP4iI/H4siRlti5rtyusXQmGXLQ
	VlrbJ6w==
X-Google-Smtp-Source: AGHT+IFj0wvocN7udOja7ZU9Z5tfL0W4WzJZ/u4zR1QPaFnXHeN+2s8eibAzO5VBKu6pS46MI8jjMA==
X-Received: by 2002:a05:6512:350e:b0:53b:1e70:6ab4 with SMTP id 2adb3069b0e04-53b1e706b9fmr4439829e87.14.1729794319539;
        Thu, 24 Oct 2024 11:25:19 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223efbabsm1438999e87.103.2024.10.24.11.25.17
        for <v9fs@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 11:25:18 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539fb49c64aso2177931e87.0
        for <v9fs@lists.linux.dev>; Thu, 24 Oct 2024 11:25:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQdJXv9+9CRZBlHv9t3jBj94MoeaN3CnJ6QRPKVZ9B3ljusNQ3XDAOMv8sJFxmFTXqTx83@lists.linux.dev
X-Received: by 2002:a05:6512:3b07:b0:52e:936e:a237 with SMTP id
 2adb3069b0e04-53b1a328288mr7321722e87.16.1729794317051; Thu, 24 Oct 2024
 11:25:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241024-revert_multifolio-v1-1-becfa0dd385b@codewreck.org> <CAEf4BzY_j9e3Awqn-mOmHOy4+SWn752mXX+mySQYdKoEHr2RPg@mail.gmail.com>
In-Reply-To: <CAEf4BzY_j9e3Awqn-mOmHOy4+SWn752mXX+mySQYdKoEHr2RPg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 24 Oct 2024 11:25:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjtTofbM7_D0GAFJL6j3cCLeBAkmTWGkwAB6U_VjcE8EA@mail.gmail.com>
Message-ID: <CAHk-=wjtTofbM7_D0GAFJL6j3cCLeBAkmTWGkwAB6U_VjcE8EA@mail.gmail.com>
Subject: Re: [PATCH] Revert "9p: Enable multipage folios"
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	David Howells <dhowells@redhat.com>, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Oct 2024 at 10:58, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> +cc Linus, in case he decides the revert is necessary and wants to
> apply it directly

Ack. Applied directly. Thanks,

                 Linus
