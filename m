Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EC8125B2
	for <v9fs@lists.linux.dev>; Thu, 23 May 2024 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716480173; cv=none; b=WqBkUoM1X2hiwrGccf/PO/qYmLq6NYRN7CUAU+89qoJzfu2sy1wczp94nfpJWOOocFxXhlcKZwZsTra9Hb/l9HbRR0uq7UDoKBbfGqC6n7xDieySgfp+rDwTInCTx5l0b/OTA7CISj182s41CcuC2g4oY4DLmBnrW97gpWSkU2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716480173; c=relaxed/simple;
	bh=vxVxFdhBL0D+Pl5wU/kEjY79uQ4l+nZaAEZJfg/XxSo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UA5XnA55Ao3zET4v1qf3UFMvxiCgie5K+8W6+LHvv4oMyQzMdJwU75dLxXurcjHVYiGjt+4dM6pqqaWJmyxUJjqT6/KL+T2LkuFrlxYB+lQZHTuGaGKzWSK/46KTGknrA8y6m6rCmbNfhGvD5pJnssHzrwnnLkKk26UQuMWqBUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0jhP9j/; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0jhP9j/"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dee72970df8so1765509276.0
        for <v9fs@lists.linux.dev>; Thu, 23 May 2024 09:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716480171; x=1717084971; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oTK4ZJ6KcR+Kt32Aoi6KUrNLuVM3Mt9ieI9Zt1eZzF0=;
        b=H0jhP9j/zUv0XqUl+jdcEElW38BgF4f9mrUYHQkGk3qBl42QUJxe76M091QmGh+RnV
         svo5kT5tq39pn0mG7WysoU6n26kpskEKzOh6+ktPD4xvi71vlptra1vZ6fvZytHuOuvC
         DmHk25ix8AdzEpNvJmSu4ISIXvicQWVXlkF8mMD3yMk1vUKbBm4inl08hER0YFzXW+Ys
         qf6nR9MrfEYXpZ52fFg7Q775WaL5IQR6SHRjsKyh03sLIODgHzjBK+IvHefI3V5sI93q
         HfC14Tbudxi5L+q9q4QcsPAc+C9SuLiULzY/Oviqg4BdPP++Hl0lVNcCwOionhb2AEpH
         Kc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716480171; x=1717084971;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oTK4ZJ6KcR+Kt32Aoi6KUrNLuVM3Mt9ieI9Zt1eZzF0=;
        b=cs0/LkVFd9ZGdxeQWTHDR+vSlMAo50CcpAJzRLLxGgs94GMJ/dy//qrZH9fqLXq5Ym
         duI/Qt6WKoqFlbbrTbe6m1ogbkvBzWW3yERF3prIZMH3LZaZHYbqbSTWk1JnmtDpAIn/
         in1jIlevfzAbME0VpQoGdFeTGBUJhR2eriPeMYzSknuh3XW0EATwZXsH1vdNSzZleG6e
         hzLaw6yDHHXozvdjSF/vX6CJYnSseFXpZy5QQq35Dmo7W5BlZjDcLf6IGFIuxCXFSnzV
         8khVqVFFu23EwiaoGraOHV9DQmc6pf7y42ZPk3j70+mgjq++QAMz27BslCDrce4Ep5ul
         xxxA==
X-Gm-Message-State: AOJu0Ywm9Jt+pkeP/AeatYh3DPeLBJFnT45WHnS3nlO24ncMrcF/5Yew
	+cNt2YOIcPlPhYxD0ULM9e+xcEJKplB4c1Un375yUw7NPMGkma8r+tUlSIkJTt5c/XVDDWpWmiI
	Ovm40CSJtNxmgclv242/1ANf6uiOdKg==
X-Google-Smtp-Source: AGHT+IG+aj3/eT1IGlzq87gZYqx6DVPvQcjPjuJIix1CiC1OoIbWK3Kavl/gaT1jXY61vMJD1fPYLyYmGnr+GNTjhWA=
X-Received: by 2002:a25:aa73:0:b0:dc2:3a05:489 with SMTP id
 3f1490d57ef6-df542250e39mr1901495276.14.1716480171093; Thu, 23 May 2024
 09:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Eric Van Hensbergen <ericvh@gmail.com>
Date: Thu, 23 May 2024 11:02:39 -0500
Message-ID: <CAFkjPTnRZRnLja_s=vVPpoyB4BQttEs914Ej6SpGtfugD2=XUg@mail.gmail.com>
Subject: multiqueue
To: v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Was looking at the virtio-fs multiqueue description -- on the face of
things having per processor virtio queues could be a benefit for us as
well at larger scales -- although I imagine there are certain
crossover points.

        -eric
