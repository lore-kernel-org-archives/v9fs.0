Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793131528;
	b=deDIZ7l4TTbqSseBsyeWN9/ZQCg7oXhG1G0AzDIDUPZ8VS7pFA6+7wlTGGV6BSOzzx7E
	 0oIfVZ5rSYNZAOjC9p8zhSOFI61a59LKVX0y2TOBDT2X1h61grwYKiChYDgn77VsyjEr9
	 D5bE0I0AWo5M7zfOU2wGOTogh75tTMILM6TdZwDZgGxxLiUHG5dG9r3YnzAIGRTL3/IgG
	 sfZFK3640HjJ6Mw2/Li8VquK8esiph/5ozVgP6TryDK95zQl3eV0ymPYOcPop/V0ElN3M
	 vldqkpiadzkriB0gZgTTkc2pYJozmG0Bc3TdTSt94giGjoMQPr9XoJBobQAtaUsK5Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793131528;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=a3lIrKPVMhtRYL/RcRw+WlUdjpRNkiI37olf2kGdOFU=;
	b=KNICdDSVazM6VAkcXu8vGn5koKlxMgngo6OWfcjPEj4xQNUw40OzKFo1rM++XPZK63ui
	 oEHm+acfh5sgZ4i4MOoflU7rpYFZIswx1bUAFhNsJbz0MKDDUK8mXCURrxDBGgunVvDWn
	 c8C43yLby83rCiknpPHa2eCuHnqfssz4uEQwLMTDRpBE+AC4RwL/BixG6hftJyD65xOsX
	 E0D6aG515b/CfwTC+RQ3mn0+RdCNcwCC4Jr5xiZZmWUz+dxfVpHvPjf+IziW0anEN8bOn
	 ZExc18x47xVlNMoifqwjyPJIx4kDjaBa8IFr8FbqJwa/EYJ9eyY4bzya4/SfD/Ng5Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OY1NPAJA;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09836606A31D
	for <v9fs@lists.linux.dev>; Tue, 27 Oct 2026 20:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09836606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OY1NPAJA
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso2614145e9.3
        for <v9fs@lists.linux.dev>; Tue, 27 Oct 2026 13:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793131526; x=1793736326; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a3lIrKPVMhtRYL/RcRw+WlUdjpRNkiI37olf2kGdOFU=;
        b=OY1NPAJALPz8aQRWAWDSEgyWX6vccijcEWMQdF6PDj2k6LTtrg+O0hKjfOVHMkLKaA
         9we6MnHAldMwXtEdo/u8umVb3qROZoiLby7ogo9mtSXZ7wOHlgeMdAX1OBkSbPNyu1fp
         i2aCHVZkcWx4tVa1rkuiVBvRP5+nbqHf2GCgjIw5kmnHH97cYWBQBc25FpSZ9OPV6U3+
         q04eVi7KWXhD5y5KvYahnZZFCosH43R61nTL7TC7+X18aD7iiLm06mMLMbTNKpW8LHFO
         jkfVMymGSw1iTVG1Tz0CwAJusXxTncxRQa3m8RZh0AkyJhYli6RBvJ5maK6PRD8ddbXQ
         gOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793131526; x=1793736326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a3lIrKPVMhtRYL/RcRw+WlUdjpRNkiI37olf2kGdOFU=;
        b=fXZ8o9YE2DPk1J/Jzwjwvw81GyhZKOtFXsyj/W1LtFnJ3BbOKsQa21Mo+BAauDfMCS
         f9PdQftWykd2MugA194AwZ0IyrJLrEe8IVMO4pHXMmUuORmyRrNHOi175WaJjrVf0rYb
         DkHJk2bHvhP7BiJZWZqGVvMVOtrbIdhNl4r5d1HC0t8oyNJFU6F4RY3lNpdUJtQCdMmq
         sfBlUiI44IOfgcoJGqtSNXHQEUpGJCzytMrTPG3/ntukxORsHR6TjkCPRZ2NU5LyzVtW
         qKhrYIKHsCpfKyhVENQzomnitRglTLoxeQUagggEey5ZzEFRacKCwNWtLfK6eP3lxkhh
         QT5w==
X-Forwarded-Encrypted: i=1; AKwUvBwRMjwYHdP8n2Bc2xHTYU/mA0SQIZ7vA/xqPziOOzKxYRssb1FCw3kuMVu1mZZ1Y5mEx2/n@lists.linux.dev
X-Gm-Message-State: AFq9FYL49ptDOWT2cxdhsu5PV8SCuNopiMXRDvZVOT5ORxnOXAc2H+mU
	BboPunS7HsVRfBFWR+jXqga6/6VYWJWK9BL1NMMd61HZyANSAFKZMxdx
X-Gm-Gg: AYBFou2LpB6gdQ/AIS42Xw0zP8spNF7YkupQk2irpjNqZ6/c1OnKc4NWt7rM9ZWaAmz
	mu9lwWbmfp6ZgCvhA6okCFHU325InCnyN65lSqvSvFc5sYIaMbi58BCrHw85APPXdXQpYQi/GNx
	fdbirdEQDq+7aeTXSsMtxDPspubUbv2kCr+1WeEndGq2ilSXTfVRMEZcBYuXYrONgjqKv99lhm2
	joYKtUuvKGTv0HOzoeh2U00vhqPXkBche583j1psoQ+OtHds+uHECuJVS4quoAlcLWfvDnNQNBH
	5gvSHp58q/iR2zXGQgssb1VS7AhEfb/IdW2GQHg5EekCydPl+FeoqVWgURlUdsNtG9xH+hTCY1w
	a4EIid/i2Ve/2RHfJBfTQbc2njxqOOgrGQAuOWRoJhXc9+XVttq7Iy6DjKv9auNogGag4a3KY5X
	IHi/noQu57XYEHduIqNYYO6MaMFcK0xkE+89vgoNij0ClY+Gqru2AWuJ5mzwGCVmcH9e4LDSwyW
	rGtSAPkauNEli7HRrCjY3e5ggkbKgNijzxHI3Lr5bwi4BdSTU4Agvvtc81/ZXGBIlG4Au9Y2HsT
	kr9jpk7kIClNfsizVFchTIXXgDKfrQRZmqObwmE8Wb9CscmskoydwFMH
X-Received: by 2002:a05:600c:b99:b0:4a1:f99e:f22d with SMTP id 5b1f17b1804b1-4a96667bb22mr94245e9.6.1793131526167;
        Tue, 27 Oct 2026 13:05:26 -0700 (PDT)
Received: from localhost.localdomain ([45.152.96.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a94e3c638csm4183685e9.8.2026.10.27.13.05.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 13:05:25 -0700 (PDT)
From: skvarlamatus@gmail.com
To: asmadeus@codewreck.org
Cc: ericvh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com,
	lucho@ionkov.net,
	sgarzare@redhat.com,
	skvarlamatus@gmail.com,
	stefanha@redhat.com,
	v9fs@lists.linux.dev
Subject: Re: [PATCH v3] net/9p: add vsock transport
Date: Tue, 27 Oct 2026 21:05:22 +0100
Message-ID: <20261027200522.94192-1-skvarlamatus@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <arI7p2EinDektW0n@codewreck.org>
References: <arI7p2EinDektW0n@codewreck.org>
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dominique,

I noticed the batch you applied to 9p-test on Sep 22 (including
the vsock transport) hasn't made it to 9p-next yet, so I just wanted to
check whether it's still planned for the 7.4 merge window or if
it's waiting on something.

If I can help with anything, e.g. testing, just let me know.

--
Matus
