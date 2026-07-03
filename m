Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BD73DDDCB
	for <v9fs@lists.linux.dev>; Fri,  3 Jul 2026 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783088218; cv=none; b=PfcWRNGNJfT4ekbdlCM4xxHUkK56okMk2yyz2ZgSE1K0kjf1ZvPHipXuH97sF2zOxBJ1qDcXOZB4B5BF/oIxwQ7CqnfsTGkeeE0g+kCtb9WgyixXFAzyuYU2O5BND8PwKVi5ZyhZhrcZDM0/Rt0vQo223o39CnXkjKOOipTT1FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783088218; c=relaxed/simple;
	bh=z3nWLbVG/Cx/Kba3mYwhP9H3WHp/oKQ2Lpsxi1dduv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QciFO7VKGbp7D1VtGY6+o6nGTKdHsOpQ2z+Bpr87W7PpFKIkKr1ZaoS3tmV0tfiAnyIV02BecFb8iZC7H3Z6eqfUHS4igDp8lHhrTUJZ5Fn56Ua8/XR7c6ExUZpTLUflE8XHzsoXkUpsfSXfZBDUxKPJSAzgULnrQYWtE957KJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHXg/kH8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHXg/kH8"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493c59f740cso4266935e9.3
        for <v9fs@lists.linux.dev>; Fri, 03 Jul 2026 07:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783088213; x=1783693013; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiMqlRn9+DAqfTJqeDAdQaqG1XRdQQi1dMzxBzIhAIs=;
        b=SHXg/kH8BT4KAHNigTf/Tf9o0UPv9OmQ9oA2TUJi7RTxHRUCoRQQ0YFw29PUjgVLqY
         TBMRk4oNk+J4/mpTcJ5LVDuELuO8B2CsOWfjqjBhp6/6P5l1E6xVN3d2qvQoxO2QA1P+
         Wnq+1ahk2qmvvwGn72EOmvlk3ZZ6Ma6d5MB0UgjzuCdIvhYw3DYL4WgAVLAFeAud0AWK
         /RuAUeFnvQvz42J095A2Hexh88+3XEP90VIVl91s6tjZcPl3MGKJupycSnPcw4B3vKVZ
         m5jX1PHX3BjcHuPTda8fVyXaoM9CvJxJuY1KlmMsxDymDt66qtM17g6STijfCQI/huLS
         YSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783088213; x=1783693013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aiMqlRn9+DAqfTJqeDAdQaqG1XRdQQi1dMzxBzIhAIs=;
        b=eeuqpI46D9GNWkWYalu78CUz0CnDR9xrvaWkAvpyHHzz+eCmk88EKjIE+YB76AdDP9
         VKBadR7zXGR/se2n1UrwhfyiSKw7Kuf2zdj1Ib9ILVQtP9u31V6P6Sza3veMu+S2zZlP
         FEgxb4+tiZY1OZbC3hTHguHtACtb/ie5GulGen5w2gWnQLSZPXG78ixukHNWbdwwMcV8
         Q0WB4AdQVnTkufkIHNZwfxderrX6ITT0mleUim7K+4ULP1/Nre/FTWX5FDTacPRqIdOH
         0cbtTIs0e41Cc4KnXLw0Wkp6DaE6HAhmfp3Ah4eTpVTNJEV2u1TDafh9C94n5S+GwVx3
         pHYg==
X-Forwarded-Encrypted: i=1; AFNElJ/zW+oUD12GlUUiqzCPQwC4+9+rhPgPbfipzowt6QaIb3AlMV1FIg26a572MTd8/h15OnSG@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+jab/2H7MrRiMZsFt7erJWL6y+TgM5C6GiCzyheYoEKYrEusU
	9fsyP521F51LSaEgk1PWWS+TVjEWGUXmVNXAhn2xovRhxiXIjQ0upZDF
X-Gm-Gg: AfdE7cnKbqd7USEdf6D5Bw/JjN5Ki+feNbzv6xCClxXCFJglhhNcKK+9IE4YxZKQY5j
	c+r3ExIddSvrK8Tnxg7nqS4hP0kEfaQzB0CJ2cIsIR4HcnY6KQ9flhGrXSRBB1XjCvMMA4oJuYf
	aD6G3D6AXb6hZudIWWlVaTC8/SdknsvPXKmI/SuabdnlkEsZm6xL4FUnhqk8uH6lVrFVIUGPGAv
	9Go6xL8nb9JfiEUmQ5CokhS6rQQQ6dNVu/1O6knga6sfhaQkgEeA0eG4lvBh0jBKDpuNdmE5ZGd
	POcOH1V6bXbOKiJnI3HdsM5jFs8sowGGZ/riWg5HVo3iFT9FfW+8c+On9O+qVn15f8iXVjTfg/F
	b+UQutdMfSXU50cFfsw5QWeJDVSTauDXt4CeZVY+FVH06808GlzrFeajx8cEmMXm7zxLItm2ws0
	wd/o2A1Z20A+jQsxwoyAa9UGqBuWTHrr8FhGx5as1pKYWBUSs4wlSyep5536PKlGjHMQ==
X-Received: by 2002:a05:600c:2906:b0:493:b6c2:cd96 with SMTP id 5b1f17b1804b1-493d0f0f868mr652795e9.12.1783088212408;
        Fri, 03 Jul 2026 07:16:52 -0700 (PDT)
Received: from localhost.localdomain ([85.193.42.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63b6f28sm139907755e9.9.2026.07.03.07.16.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 03 Jul 2026 07:16:51 -0700 (PDT)
From: Matus Skvarla <skvarlamatus@gmail.com>
X-Google-Original-From: Matus Skvarla <mskvarla@redhat.com>
To: stefanha@redhat.com
Cc: asmadeus@codewreck.org,
	ericvh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com,
	lucho@ionkov.net,
	sgarzare@redhat.com,
	skvarlamatus@gmail.com,
	v9fs@lists.linux.dev
Subject: Re: [PATCH v2] net/9p: add vsock transport
Date: Fri,  3 Jul 2026 16:16:50 +0200
Message-ID: <20260703141650.44283-1-mskvarla@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260703054133.GB448934@fedora>
References: <20260703054133.GB448934@fedora>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jul 03, 2026 at 05:41 +0000, stefanha@redhat.com wrote:
> If you respin this patch, please add the port= option because it is
> absent from this example and it could be missed if one doesn't read the
> paragraph below carefully:
>
>	mount -t 9p -o trans=vsock[,port=<port>] <CID> /mnt/9

My first idea was to have it there, but I removed it before submitting
as I thought it would be redundant. No problem with having the port
option specified in the example. I'll submit a v3 with this change.

--
Matus
