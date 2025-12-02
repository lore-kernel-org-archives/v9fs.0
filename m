Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E580A2D6E7C
	for <v9fs@lists.linux.dev>; Tue,  2 Dec 2025 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764714897; cv=none; b=XxpjqcTl8u8aYeUWcigMw4eQIcDKcQqhautEk6GerR6ZdFLSadm74U3/rAORWKooanbZ0IFsBTm0Lyx1bUlCCnPlz7dQvg2rdOu0pRJmwXsUN3tRbHN9VAqP1O11mX+M0EJo88xaluNDlPDt6AUy9s4MLG6z7ZsLuPXWhK7pkiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764714897; c=relaxed/simple;
	bh=knGCB2QWCi7I+b7T8oml1J2JVo/fTrJd+ijEv1ZyS1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tFHqW14R8fTtp+/Q76lT9Jcw8AL7wyqB1cIblwxRZUSyi8lfpHT3AReAOZzpbfbkm2oHQezw4/42VT3XEsT2b5ykOLZjqX9QRKDOj1c0iwxVUPDo467gzKyeTdcp1c3yuuNwslu7OMvF/p2HaopC1BQbYXnGTvbdlBfIqSLpRl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S3o9tcEh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3o9tcEh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764714894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I75stScld0jImIWnHzAwTuoOvKajHCPvGtn9toaW0BQ=;
	b=S3o9tcEha85TpN1QEl8bhFezoSkV/rMN3xpG2KWRyROury1p2rzLebR2/iio+Knm38fbJT
	bvqY9vnp3CRV/cAS5oY5zV7dT1gnrx+yqelYfEXg9iO0fxvsx7DEoM8s9P76L6N34VX5kn
	ND7918BMkV/yD+EhYwZ4bbfJY4Xm+3Y=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-vY80BPtiPm-nClEQUvhtgA-1; Tue, 02 Dec 2025 17:34:53 -0500
X-MC-Unique: vY80BPtiPm-nClEQUvhtgA-1
X-Mimecast-MFC-AGG-ID: vY80BPtiPm-nClEQUvhtgA_1764714893
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7c6ce3b9fa0so4070867a34.0
        for <v9fs@lists.linux.dev>; Tue, 02 Dec 2025 14:34:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764714893; x=1765319693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I75stScld0jImIWnHzAwTuoOvKajHCPvGtn9toaW0BQ=;
        b=lnZyroaMoNcbX1YJhDqRRyMF2q9go9v82dQmHCDRrHWSacdfZuigiQCqf+ocCa2UjL
         Lpu1s2f4W12FDegFXYRTb9yaw1z/klM+xEBM8N6NGmMT5KrK1tKhw2fUvSCKWqJjQwiV
         eYMaMYPexLXO42PjMfGH9uEfPGN002QG0+xmDxy3MsjN8nEKmePE57Piiv+7w1iylc5E
         hFyRmvH4Tqd+W3+n9TR3ZqmYvJuSloJVHrL0cCzbRd7j8Eqfs5hb0s5umPOCpoGoSNDk
         RpHmbvX5Op8mVNRfnl49h7pqYbgwzwM/ZUeZPADZrl62hgsMMddadErugdjKZMatAlE4
         RUzw==
X-Gm-Message-State: AOJu0YyzhVFaR3uD9luODochiRQ9dDE4mt5vOPO7mH5IJPfdeOkqjZYH
	oKCIlWwZ+UoOdQEh4VxS3EK6FQUKn3zBqPWOd3AG83P6X6q0p9+KZ5L6FmOFfy6lXc5SUCHHYgX
	xCxXnBMACuYeFUGgt2P996lfiugoLlS3PkazV9trjjSrh4k1UCcRZIRf2u2VS3ju4wadJQcQRRs
	4RlsAlu9zvfY3e/7XR7f/PqjAaUbvOtd/eXSPsUkdh
X-Gm-Gg: ASbGncvRIRZn9Lu/b0MN7olUxpXClMH9SPWFNwBSNdVytKAdOF+KGEE/ROJBXHItv+Z
	4XitweYfl7iJYZ1kRpk6DgYv7OHuwfxajYgSaOxUjVRSKI8QcQL6bu9CV1JBWymdZbxTE/jC7bQ
	fo+7uB2uaQqDXfM8M0c0onFY4SsZ/+i2Tm+1pNMuqVMDYki/cRfHZyMpOh2q8GK1wHOmjQphjeD
	JlkT2fU5HJgRcNP4WIzWeTatei/8liu3fNIA656Mg0yYxpWy0c7EgQjaWiKhWbd+m8YMtrncnXO
	hjZP5Xs7xr2WK3KXIEESZG6vyzmxqKMnjjzZrAvAQVebgYBnsKlrVW2cYZt1kCRcOFdqJgodqwP
	YtgRFeOmq0GX0ETpYwanDNrcu8Uesrd0mvPTPcY1l/jc+3nnzFoM=
X-Received: by 2002:a05:6830:310b:b0:78e:a394:ca24 with SMTP id 46e09a7af769-7c94db16322mr243471a34.8.1764714892822;
        Tue, 02 Dec 2025 14:34:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBk5xgbqxkiF0SI2w8qIvhL+LUE6hwtLWp1H8RJuryPPzCLFIrSmuLFBL1JZq1IvKtaEk8Vw==
X-Received: by 2002:a05:6830:310b:b0:78e:a394:ca24 with SMTP id 46e09a7af769-7c94db16322mr243453a34.8.1764714892458;
        Tue, 02 Dec 2025 14:34:52 -0800 (PST)
Received: from [10.0.0.82] (97-127-77-149.mpls.qwest.net. [97.127.77.149])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c90f5d7ba2sm7520115a34.5.2025.12.02.14.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 14:34:52 -0800 (PST)
Message-ID: <48cdeec9-5bb9-4c7a-a203-39bb8e0ef443@redhat.com>
Date: Tue, 2 Dec 2025 16:34:51 -0600
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH V3 6/4] 9p: fix new mount API cache option handling
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 linux_oss@crudebyte.com, eadavis@qq.com, Remi Pommarel <repk@triplefau.lt>
References: <20251010214222.1347785-1-sandeen@redhat.com>
 <20251010214222.1347785-5-sandeen@redhat.com>
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20251010214222.1347785-5-sandeen@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aEFbGTsRuUevQ-TuBXuINcSoO2wQltT9n-5pD5J9Uys_1764714893
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

After commit 4eb3117888a92, 9p needs to be able to accept numerical
cache= mount options as well as the string "shortcuts" because the option
is printed numerically in /proc/mounts rather than by string. This was
missed in the mount API conversion, which used an enum for the shortcuts
and therefore could not handle a numeric equivalent as an argument
to the cache option.

Fix this by removing the enum and reverting to the slightly more
open-coded option handling for Opt_cache, with the reinstated
get_cache_mode() helper.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

If you wanted to fold this into my original mount api conversion patch
so there's no regression point, that would be fine with me as well,
of course. Sorry for the error.

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index d684cb406ed6..dea2c5347933 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -72,15 +72,6 @@ static const struct constant_table p9_versions[] = {
 	{}
 };
 
-static const struct constant_table p9_cache_mode[] = {
-	{ "loose",	CACHE_SC_LOOSE },
-	{ "fscache",	CACHE_SC_FSCACHE },
-	{ "mmap",	CACHE_SC_MMAP },
-	{ "readahead",	CACHE_SC_READAHEAD },
-	{ "none",	CACHE_SC_NONE },
-	{}
-};
-
 /*
  * This structure contains all parameters used for the core code,
  * the client, and all the transports.
@@ -97,7 +88,7 @@ const struct fs_parameter_spec v9fs_param_spec[] = {
 	fsparam_flag	("noxattr",	Opt_noxattr),
 	fsparam_flag	("directio",	Opt_directio),
 	fsparam_flag	("ignoreqv",	Opt_ignoreqv),
-	fsparam_enum	("cache",	Opt_cache, p9_cache_mode),
+	fsparam_string	("cache",	Opt_cache),
 	fsparam_string	("cachetag",	Opt_cachetag),
 	fsparam_string	("access",	Opt_access),
 	fsparam_flag	("posixacl",	Opt_posixacl),
@@ -124,6 +115,33 @@ const struct fs_parameter_spec v9fs_param_spec[] = {
 	{}
 };
 
+/* Interpret mount options for cache mode */
+static int get_cache_mode(char *s)
+{
+	int version = -EINVAL;
+
+	if (!strcmp(s, "loose")) {
+		version = CACHE_SC_LOOSE;
+		p9_debug(P9_DEBUG_9P, "Cache mode: loose\n");
+	} else if (!strcmp(s, "fscache")) {
+		version = CACHE_SC_FSCACHE;
+		p9_debug(P9_DEBUG_9P, "Cache mode: fscache\n");
+	} else if (!strcmp(s, "mmap")) {
+		version = CACHE_SC_MMAP;
+		p9_debug(P9_DEBUG_9P, "Cache mode: mmap\n");
+	} else if (!strcmp(s, "readahead")) {
+		version = CACHE_SC_READAHEAD;
+		p9_debug(P9_DEBUG_9P, "Cache mode: readahead\n");
+	} else if (!strcmp(s, "none")) {
+		version = CACHE_SC_NONE;
+		p9_debug(P9_DEBUG_9P, "Cache mode: none\n");
+	} else if (kstrtoint(s, 0, &version) != 0) {
+		version = -EINVAL;
+		pr_info("Unknown Cache mode or invalid value %s\n", s);
+	}
+	return version;
+}
+
 /*
  * Display the mount options in /proc/mounts.
  */
@@ -269,8 +287,10 @@ int v9fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 #endif
 		break;
 	case Opt_cache:
-		session_opts->cache = result.uint_32;
-		p9_debug(P9_DEBUG_9P, "Cache mode: %s\n", param->string);
+		r = get_cache_mode(param->string);
+		if (r < 0)
+			return r;
+		session_opts->cache = r;
 		break;
 	case Opt_access:
 		s = param->string;


