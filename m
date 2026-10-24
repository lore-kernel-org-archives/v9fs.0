Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833741;
	b=3YOn/6j0IGy7bdrOflq1MM6WSXSdJP920rQIPqkhJzNSqDJIjhAOGngZ3BEmeC1xC2fN
	 z9A34od07ZjV6fxJd2nBgV0GZp9VYmy0bbRMd3M4BOiESrA6dF0OK4kXHan+SUI0XCVZF
	 VNP0ceTJQnDJFnz/2zhItmDp2Wyx0KIIl2tgTpk8IXp1pgJHXPlZX4+h1Hnh2fldUyrRm
	 mtf7cREMe0Fn08jN1YeigXDAIl78xUWbNdt6efl/Ytrl040wgZZEhJQj6xqugTQhzlXXZ
	 Y6i9d5TjLRIbphARB3gn7Isra8ZQSxmNEnevvVEY2bbsO7DXWX5YyfATQq40/YbJXLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833741;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=39sy2Cofz084B/ibmtf8XrBJzGPCGIsdEfHYkkJWmIc=;
	b=4RHEDiR13CPxyEQwQKilbO9cQdIUL28fm4pC3KRzqRAyEk21nSYR3zxYxnK59dagxTf+
	 8tvGE/u2HcY1C10JtgYUfEXdG4sVSinuWmWIIct4USqbBYMfNBR/HX/5qJaX0NS+nDc8b
	 BO9K14dbsJE4UTNoKbHtB3hpmrj3PTDEobhJBGlRXgmEpSo/d6nbIM1g3vepuR4iBM4Yr
	 jb3EGx0YvILlmjDio6kJH9K7wvuIqoRPvu7pjaUoQHLPpsEC9zojdSTDoOYrhJiGNyVbD
	 OtPtGrbCAPD+0GwnTOhuAbWWSz2NqtqSaxincFwKe2CDgPGqjC3GIiD4bzaulQj21SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FYKhfhmt;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7647F606A31E
	for <v9fs@lists.linux.dev>; Sat, 24 Oct 2026 09:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7647F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FYKhfhmt
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-368581df789so1833867eec.1
        for <v9fs@lists.linux.dev>; Sat, 24 Oct 2026 02:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792833741; x=1793438541; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=39sy2Cofz084B/ibmtf8XrBJzGPCGIsdEfHYkkJWmIc=;
        b=FYKhfhmtcZzyP/gDr+uNEaskzNL8qpotmbeizsaLLVDzgOj90e3yqJpVdmWENowWuG
         zV0Ra2VQmfMYLgCiGmWnC/9Tdklvj+m86/8HUAEvJ/UD8nNIaZGW/47LqFgfbt80srot
         bmYne4LSvbOy1dptucVN1dUBdVGWry413FgR3zjPFe3L78Pm5UrUOUd1DknH/AC7xBen
         /FHkEI6BfHs0hzWlGxKKWNPIRFT2z/9UFzonXp/kRFl7eld9qhRlv6WEG6GjlJq65Y8V
         DbUY9STbW/qWSJRrTmpSqk32mjnrMb1lMFX4G9IhQghBaVSvZMCxYcgjCKd+mOBsuEPn
         D4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792833741; x=1793438541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=39sy2Cofz084B/ibmtf8XrBJzGPCGIsdEfHYkkJWmIc=;
        b=WSAWZZfy1lZgpv5J2G6bOrzIkDfd42Vo97cRSR+cPjqT6WdsdkbjyWGTU5URXQsoJl
         xWdzdnkJY/aj/rU42yZVPbUD8jt2gebpgh6HHSir5FZLTYDT9TVGn/8CNqe77/c6TQn3
         As3hd8VibON9hEI5RLNyvJhkaFTXkxkwOfbVyVmfiaHb7ZpdIqUnoB+gsHIYXnOg7oR3
         6hZ2MxrM8AHeVLoLTwVoULbRApRCyy77b1+Ylp8dEL/kBMW8p1VuQXqdg0+TTMnczTNP
         YCa/DjxDZ7T1Pp5W/HQX/hBwHax6fGoHQk3Wt6qBwakE+mqz9dJq2OPLnNWu+JL4Zfrr
         OgRg==
X-Forwarded-Encrypted: i=1; AKwUvBy177YSnIf8zp+/ayj+QINm+8fNHZAyoxFHDjXAdukK3xEHluuL1H7SUl+e/y80CJyXI8mc@lists.linux.dev
X-Gm-Message-State: AFq9FYIqAXrFmv95iEg0W6uxXG7O7RT/VVloLzAGcUDTSXG65FTSGFxo
	v5+fsdsamFzv+gB2Jg2Vr6Z0k3XUqT07F80Lwm1Bhdqtz5fvWRxe/TwIkpWGqG03eAQ=
X-Gm-Gg: AYBFou1tgNd9/QbpE87Twt5v1jG1NHXEBgC6V7QIHUOeb60POYM0lFVegBZ3hVBdXpt
	Hw9tpk85GkEYUFe6FOQzMnB41Zwz7rOMoiqVCm/jPFsm3VPglN/wodUYvdPl5MgEB79z9heGnTH
	qNI06R9BlgHocT69ib1TQQi0qxGHISyuqQ24Q9GT8AYe0WzaY8BROSf0aYdyyqT+JdDnBVbdZex
	RWrmrRVRI5vgB2GyLVl6MxRsYO2mDccvx0X+cy+sa3clUT3WKzhfuBDxm434tvDwxBjFpsRQbFQ
	1VInPD2apVVcCYzBnipN5x4nta0xJmUK2JJhIZY8Oe8GOVCO1Ci5DDbSRvQdm/HZm3s5XAaI8Sm
	qx8Zgp6epW9HEr9kalBGIF+Bj6hDFiyN7flNqVmoLO+OMgYecWpWfNDpMOQUSWqvyD+8VQr0mK5
	rnG6pWh9BLVPAWlHfFtG1wFKEch7HjupoXauZCFKIZSuH3fVSmL2wuu5WpaHR75fJTErbgY3aK3
	UGwE1/J4CgpXwiBVjNKNsBZ2iSAr7KMG8CiCGEBVtb7bfd/vpqIXIC9C4EGGUC9Bnx4U3R4uG9B
	86Q/DsI/1jfe2p/NS0slI/fu4Y4gys4i26O3+MJy4TBXRa5ewAHHZcbgGZ7AJ+uNLOAwWZda8oT
	1nCj/fUa4334qWymuj3dm6w3QUA==
X-Received: by 2002:a05:7300:fe09:b0:33e:61ab:8309 with SMTP id 5a478bee46e88-369e85022edmr2030334eec.23.1792833740612;
        Sat, 24 Oct 2026 02:22:20 -0700 (PDT)
Received: from LAPTOP-VN8JNK11 ([111.223.26.246])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8db450bsm5108584eec.17.2026.10.24.02.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 02:22:19 -0700 (PDT)
From: Ankit Thakur <codeankit.thakur@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ankit Thakur <codeankit.thakur@gmail.com>
Subject: [PATCH 3/4] 9p: remove duplicated assignment in v9fs_fill_super()
Date: Sat, 24 Oct 2026 14:51:53 +0530
Message-ID: <20261024092154.1844-3-codeankit.thakur@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261024092154.1844-1-codeankit.thakur@gmail.com>
References: <20261024092154.1844-1-codeankit.thakur@gmail.com>
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

The declaration of v9ses assigns it twice (v9ses = v9ses =
sb->s_fs_info). Drop the redundant assignment. No functional change.

Signed-off-by: Ankit Thakur <codeankit.thakur@gmail.com>
---
 fs/9p/vfs_super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 795260446..7b67193d9 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -34,7 +34,7 @@ static const struct super_operations v9fs_super_ops, v9fs_super_ops_dotl;
 static int v9fs_fill_super(struct super_block *sb)
 {
 	int ret;
-	struct v9fs_session_info *v9ses = v9ses = sb->s_fs_info;
+	struct v9fs_session_info *v9ses = sb->s_fs_info;
 
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_blocksize_bits = fls(v9ses->maxdata - 1);
-- 
2.55.0.windows.3

