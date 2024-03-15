Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047FD3DBBC
	for <v9fs@lists.linux.dev>; Fri, 15 Mar 2024 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523090; cv=none; b=KLhPgOTrw3RRq7Bkxbur4kWMtYHOZoHlwQcrzDrR9Yhq1k9DamGOi2vU92Tp0m1ljfSqTp2QRmX5l/OUQGpZBt/8/gE7mqeiDlbpTtPFxdW9DXJ/Dc5iwkHsIDwEWCADgMdFqP2NOSSkrzVyPHEgZEuNyl8hEcU+0j6YBF5YIUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523090; c=relaxed/simple;
	bh=3vWfh0H5SxVCroF08gpjZrm2nJHf5wITsVROD33t7GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vjl6dkeQYt99AVkuCrhuIooul/ozoNV7K5gmparrnSOghdnmhyKWKXV6rO5bqOZzu+ARWNG3Cl/UNl3wzE8h+Pn/GluEgl0D7VqDyBYIQfBkgWtJTgHCdCFckViJ6Mf/khO1IkGYrOekcFHH2SjBDdrEZsVJqX2EkUu2staj2xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KjHUA57K; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KjHUA57K"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so28410411fa.3
        for <v9fs@lists.linux.dev>; Fri, 15 Mar 2024 10:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710523087; x=1711127887; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YXJYJHH6Vt4w4K0aX4imlYYQDBwG04/7jCU5kd/9Afg=;
        b=KjHUA57KdMZaam7FAQXEW1QLYOVOxuUmf4dIe6w5nRGJ5jet0Y5CSYUBY+epJU+a6e
         clY3od0hRvbTWTlBZv8sleyaCOWKcpK9SbNvW53oPKuVF0rPm1KwvUpb7xOOYzu8P5tY
         fJOJgI2ZJ7e0POUdrvrte5U3u63aZVLM8hb3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710523087; x=1711127887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YXJYJHH6Vt4w4K0aX4imlYYQDBwG04/7jCU5kd/9Afg=;
        b=t4EvzDN4G7FAVGHuEJ1/wepU6q5UT173GkttrXkr52RVqMt+9Kdvm60y9qTHZrNWZd
         loVU4cy7PFUeBKv8irPFUxgbOGuj8Fp641Ed9yIYq/YmWLu+Cx7yBqT1knlyeucekOTo
         CQpIz0IYrb5GwwKk9ZLUYbhfiyn394mSCTK1JLvaO0iYTcPzLO8he80KQ/I25kNxgWtA
         scBPDOEBUoZbhU0/lA9YTDyTmo0SfAtIzFqip/pvRv3mPUwmTkISw4Rk4nvEbqvwzH7Q
         NIyqmdUyC0oSxTohrp1wItqf0L2J3Sj/K8CrbrOmlpXJtkRF2YVujs2537r41l4/akfc
         ThWQ==
X-Gm-Message-State: AOJu0Yws+xwbCcN20mzLCXPpIDjlHtkDG+4mti/8McefNxcnpuZIpK+v
	Tufpv5LLTzi7dWk5ZUPMJp5hrQ9NB12j6UY2gJQii4oxrhSEuzOUQd3BdQ/urubdvQeff58gVBm
	PfGY=
X-Google-Smtp-Source: AGHT+IExk5xj+R6zJHWRJFsDdwf2FYJ0R8I5DfVEnl+7d5jJ9016i2aNKNdfFkNXO/g48tFWkev5fw==
X-Received: by 2002:a05:651c:11c7:b0:2d3:f3fe:48ac with SMTP id z7-20020a05651c11c700b002d3f3fe48acmr2140493ljo.27.1710523086955;
        Fri, 15 Mar 2024 10:18:06 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id a3-20020a2eb163000000b002d45f5c5b7dsm563424ljm.13.2024.03.15.10.18.06
        for <v9fs@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 10:18:06 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513cf9bacf1so2957591e87.0
        for <v9fs@lists.linux.dev>; Fri, 15 Mar 2024 10:18:06 -0700 (PDT)
X-Received: by 2002:a05:6512:61c:b0:513:cff9:46b0 with SMTP id
 b28-20020a056512061c00b00513cff946b0mr2642514lfe.16.1710523085726; Fri, 15
 Mar 2024 10:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZfRkyxUf8TIgsYjA@1149290c588b>
In-Reply-To: <ZfRkyxUf8TIgsYjA@1149290c588b>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 15 Mar 2024 10:17:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+=Bb8XYAexzaKWuf_6k93Xqi1OxqPw+SPf6JGTGCqdg@mail.gmail.com>
Message-ID: <CAHk-=wj+=Bb8XYAexzaKWuf_6k93Xqi1OxqPw+SPf6JGTGCqdg@mail.gmail.com>
Subject: Re: [GIT PULL] fs/9p patches for 6.9 merge window
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Mar 2024 at 08:10, Eric Van Hensbergen <ericvh@kernel.org> wrote:
>
> fs/9p changes for the 6.9 merge window

Entirely tangential, but your pgp key drives me insane, and it finally
drove me over the edge.

One of your uid's has your own name mis-spelled. This is not new.

Please tell me there's a reason for it.

          Linus
