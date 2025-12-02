Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBC42F6935
	for <v9fs@lists.linux.dev>; Tue,  2 Dec 2025 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764714660; cv=none; b=jUvjbsGB5zWgYukg+p17PBdSflIc2BE/LLsj9RwSPB1nZS1P6z1Z2l2lqv3/PJOLFTnPGwWOWNFvvuvfuQOVuolksV5R6u+AnReXYkB2zOolnuyUv0CAucmknC19mMDDP9MPbTA3xZoesy9OYq7n5AzJYMLZBLIN8tautfu+IO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764714660; c=relaxed/simple;
	bh=MmUh4MKXgs1k08VeXFr5wg8d4AsDjxUObXE1+1XdpG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayu1DTzCQIUzOvGFWOXJBQgxct86Sxvip1TXivjsNdbvERJ6gmsaJA+wHsZXtOuQKcthiJQiv24Lto+UO/FWDvWzrcBfL3uWZAYYlzEU9a3QCj2GSrcwdH8J08kHupy7EDaUq2Qijl1zkNl8MtwuZ4uJ31gVxMY4yc93FLzoKAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XpVo6Joc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XpVo6Joc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764714657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9XpYvds7AGfom+0aJqkkhOOQLSOqoY1MbT24dcNg0Fo=;
	b=XpVo6JocMQHyzkWoO8xJYKm7aOHD1Wc5n6+pnLqHAErJEjKKDjQ1btSBI8LSbxeJeL0Bkh
	m14i5pw9GbP4QAcgUy0Euw/HiQKlvLEBj0e8I2Llek4DWDKFfEnoI9H4emPfZh8uqEq4L0
	Jm6NFewM21dPBKr15ZmpDm4OYCgQHBE=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-0H-j4RCnNYKb2xmos9Ej2g-1; Tue, 02 Dec 2025 17:30:56 -0500
X-MC-Unique: 0H-j4RCnNYKb2xmos9Ej2g-1
X-Mimecast-MFC-AGG-ID: 0H-j4RCnNYKb2xmos9Ej2g_1764714655
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-65742f8c565so6233605eaf.1
        for <v9fs@lists.linux.dev>; Tue, 02 Dec 2025 14:30:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764714655; x=1765319455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XpYvds7AGfom+0aJqkkhOOQLSOqoY1MbT24dcNg0Fo=;
        b=ghrPDik0UwhqnWUGQLGHejTyF43Ef12PTymDPhjPkei36Z4ojbFAgLEGzHzoirJH3h
         eRePU/Dleqm+JRdumUycXC72SUij/DxYUHt5yKC2LCIKRAzHyWtfsjFuG4Ys1MMxTKMN
         F4ZJHeCqca6hvqZo2UHSrO2qvlcbq0z/pYzUbJPYP6md+1k7Hej+11ACi/U+nnCBv9pY
         P/SYZOBvJhw7Z319/p8CCP9VlVoDAtZom5bZkaWSinGeCBCT879pioqBvUC5OI3QitXa
         bEXzfkI3eUpAKpX3EKZqEE8++gez2IypjuyOhirNwqMDZUlCp0ws6VergoYBrlJ9v3Wo
         b3ew==
X-Gm-Message-State: AOJu0YzKiNlYnivK8hT3D8J/BTUgUTWK335VN5yA41fE4BxKq9CGwdf2
	Bxz2Y0D0tNOtEecXUupKQxOmBdInOPMChOzOZuoWpVMJgKRgsR11Pa+kIZnWFIRPs6x61fdmQa5
	gPlo3g9eOMo0n+k5CmmOW+stK24QTXDyQniRit98/A1cnUUc2XOHwYUYxQIng375q7GKEh68PCC
	FNJNZ+7uU6D3ERwdoFTU3i1YELf6BF9QoJ7FnID49Q
X-Gm-Gg: ASbGncsW4qVSyK4gnTf5WImBpErr27nZcY6Iith9aRVT6QWhWo/qvKl2PDYiEJhnIYf
	RUShauGaUelD8qjVO7/yWU6BJyCdmFP7Bbs7VGlPiwqmm3R/AJF1YcJAOC7IgyvopwG/M+xbFcm
	jbDmnkF00IWgZUagN8WDxseZGzgxwmzt2YYfyz0vWEgG0QwkSlrUQsQcOVsw6b/boQ1LQ758rNo
	kUQF4kO8cYKADDcengYqO0b46d/1kwclg+rxH6rDRVWcYCHn+Xqy5M6Ug/g88vdb3j4uvcntiUd
	wB5EmZdnq9pRjCDMGlab4e37fVklHTNE0nrYQCKTcu8czngtxZjebuaZJ8YXzFpPSGR1tzneMrl
	xnDGkQ2pgHgRDuZsMC1F5BVI5VDuy6cWAW57KmQAmDMBTG1htmsk=
X-Received: by 2002:a05:6808:2213:b0:453:f62:de01 with SMTP id 5614622812f47-4536e43a399mr17456b6e.30.1764714655105;
        Tue, 02 Dec 2025 14:30:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHy88N7ZuKZYlIvdZQmy4kg6Oeq+tbP5nzm2BGu6Vun9VEEZ04RppoINDoRk960fJq0ifc1/g==
X-Received: by 2002:a05:6808:2213:b0:453:f62:de01 with SMTP id 5614622812f47-4536e43a399mr17434b6e.30.1764714654720;
        Tue, 02 Dec 2025 14:30:54 -0800 (PST)
Received: from [10.0.0.82] (97-127-77-149.mpls.qwest.net. [97.127.77.149])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c90fcedce6sm7464634a34.16.2025.12.02.14.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 14:30:54 -0800 (PST)
Message-ID: <54b93378-dcf1-4b04-922d-c8b4393da299@redhat.com>
Date: Tue, 2 Dec 2025 16:30:53 -0600
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH V3 5/4] 9p: fix cache option printing in v9fs_show_options
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 linux_oss@crudebyte.com, eadavis@qq.com, Remi Pommarel <repk@triplefau.lt>
References: <20251010214222.1347785-1-sandeen@redhat.com>
 <20251010214222.1347785-5-sandeen@redhat.com>
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20251010214222.1347785-5-sandeen@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O3bxLosRnf69EDFr_nNdkalF_KEdfIp2jYJmCeU5iGA_1764714655
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

commit 4eb3117888a92 changed the cache= option to accept either string
shortcuts or bitfield values. It also changed /proc/mounts to emit the
option as the hexadecimal numeric value rather than the shortcut string.

However, by printing "cache=%x" without the leading 0x, shortcuts such
as "cache=loose" will emit "cache=f" and 'f' is not a string that is
parseable by kstrtoint(), so remounting may fail if a remount with
"cache=f" is attempted.

Fix this by adding the 0x prefix to the hexadecimal value shown in
/proc/mounts.

Fixes: 4eb3117888a92 ("fs/9p: Rework cache modes and add new options to Documentation")
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 05fc2ba3c5d4..d684cb406ed6 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -148,7 +148,7 @@ int v9fs_show_options(struct seq_file *m, struct dentry *root)
 	if (v9ses->nodev)
 		seq_puts(m, ",nodevmap");
 	if (v9ses->cache)
-		seq_printf(m, ",cache=%x", v9ses->cache);
+		seq_printf(m, ",cache=0x%x", v9ses->cache);
 #ifdef CONFIG_9P_FSCACHE
 	if (v9ses->cachetag && (v9ses->cache & CACHE_FSCACHE))
 		seq_printf(m, ",cachetag=%s", v9ses->cachetag);


