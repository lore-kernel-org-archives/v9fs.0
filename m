Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7123F1ADB
	for <v9fs@lists.linux.dev>; Fri, 26 Jun 2026 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472753; cv=none; b=TDhxybKwsAvU1I4YTon+eX+AIrjZQMBosZHrfk2JJ6QyqBZI6N974UumaumXShl8FT6BTFE+SpiOBV/qF6Z+RCj/c7F5vejxJxKyptrxIi+iBiSLWGgWTWQE+53Ygpu1pHQeoK6gUbdz414qF6wC4r0qj994bU+TGPllEaTMIOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472753; c=relaxed/simple;
	bh=2UyjZknl2q29KoZjZWSz+LeCKEJtIqh7DEpIeME1drE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8A9yOrmjySvRiU7JqG2aoCml9TMbvTzM95v4aLnBC1nSEQq64mCf0RtiU46ZL+y7fVX55Jb3hBNNbCQaRsaf+x3D7Fg5OQhnWZEfLBC0r8jgdBbnbhNfndZ6IWhmDh16AJijv+lf0pW6AL+HXZgYcTlvxQsPwCelNLLZMChj/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pFZsM33t; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFZsM33t"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8dd586317ccso9233716d6.2
        for <v9fs@lists.linux.dev>; Fri, 26 Jun 2026 04:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782472750; x=1783077550; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0mgUs8CYGhV8MV2nU3223A01RDP1NyxjcxAJ3tAP28=;
        b=pFZsM33tdivJ94MOS1rOxva9oVjj2zh2tWWczt8+MQz5497/6t55Gg5u22rR7YdKMa
         ThuqcOJvHwhBO0xBfQMTKqmVqU6WjS82IrnqsGtLFb49W/EhQBjdmcagKLvPYIQo0tlf
         5nyd93fPBQigoU9iUO0zZOT+C+obU6JyXn9jaoyuXDknewV92zfRGkxHSb350EQ6Rah9
         XnJZh2G+jFk1hcngBOVUNTyHHCMF2Bx8dhFlmWBQ+169CyCxXGiC/KJ+tBS2iK1+CPxd
         dB86FxlblNLBRa6Ycy8nuL+JOfmWVwuq8FadnBTpkLPg2xsewT5OJLF2T8UTQt6ceTMU
         IRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782472750; x=1783077550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f0mgUs8CYGhV8MV2nU3223A01RDP1NyxjcxAJ3tAP28=;
        b=cviZ2V9OzEzuA54nhzIe351cFgnUkNDUkA45Eo31WZJlnHIjRqnEyrY+mgXX+JEFl+
         zjOZ4VLar7Mqj4W2qms5tOsWnj2Wn0+7RiE1jEC5n54UfSXK1zsKHtsbneoKk1WiFN2w
         2/+xNR/gM/Tfi5YGUUMwcF13Om/5BVkBJjumVvEuNpzCpDkctISokjrik1P/748F/zfy
         DuCemk6ZvLX6+EBh55zXbLZ4lyJ7PeFGpOfp/HZNOp5M36dwRmTBaVbHJbDz6cGr6l7D
         7QrEtRHLEiuLXTvLOCv9niYPTa/XAs4oP/d/nTW0oerLc2azwMJHEjp/WfJguTISGKsl
         qAEg==
X-Gm-Message-State: AOJu0YyfTtbjxghIzdKuQb+jF3mrzSQJKQEUt1PLogY1o3HbH9LEJQw6
	YcXOz08x10JYz6iXwV2e1T0FIM259eD7DkEHXpZs6PIN3P04UZqibRVu
X-Gm-Gg: AfdE7ckwQxfvtMNdyopVxzJeOwENSPs2KkZNGHGOJ+4xuxyrZTjFd5oae1K/5gvF5bw
	Nu1WFtSim3e8D4fpI/cn0I6Sd3pMgQtkfpq4HlVqMhDTgcC6PfiI0ZDCUBID30wCfZywmOd55zX
	H4E8WTOgmVZeU3Z9wpx4NtrmiZPxb+9Mnq+xhQ1DH/sH1rSX/ue3xg32+zVHX9IW2JIXniVfSBY
	qhILkQWuisqmazb6u8VG8DxMBQfh7FYGey+z6sxoTdr3W/9HSaisohkIUHP6hruH9IRhkVu25hP
	VfeFUWvb9hN6XhCWKz1Xi+lPAJh+IBfrUXofG88z9RlgdT+UDCJ1ZIz77MbgBKOrAV/kf5uDOye
	YBHh++vbpydHNcrK/vFcgMKhRi2zI3eclJSu3yLHh0LSjEuQTID6RiAXerUSL55C0ZqJ1Du/qyU
	U+LS0iRVHJ6G9K/7rY1SXS6X07utascZbOPrP7U6+5IL2XRYESSWgwcP/RMQPVv3LmxhaoxIFj8
	r1qpjPFNiynzQfJVOzD26JhiaMSw24x
X-Received: by 2002:a05:6214:4e02:b0:8e7:f480:b180 with SMTP id 6a1803df08f44-8e7f480b8femr45637436d6.11.1782472749589;
        Fri, 26 Jun 2026 04:19:09 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cdf302sm220342656d6.30.2026.06.26.04.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:19:08 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] 9p/trans_virtio: reject mount tags that cannot fit a sysfs page
Date: Fri, 26 Jun 2026 07:19:06 -0400
Message-ID: <20260626111906.801890-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610114206.3749904-1-michael.bommarito@gmail.com>
References: <20260610114206.3749904-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

p9_virtio_probe() reads the mount tag length from the device's
virtio_9p_config.tag_len, a 16-bit field, and accepts any value up to
65535 with no upper bound:

	virtio_cread(vdev, struct virtio_9p_config, tag_len, &tag_len);
	...
	tag = kzalloc(tag_len + 1, GFP_KERNEL);

The tag is later emitted through the world-readable
/sys/.../mount_tag attribute by p9_mount_tag_show(), which copies the
whole NUL-terminated tag into the single PAGE_SIZE buffer that the
sysfs core provides:

	tag_len = strlen(chan->tag);
	memcpy(buf, chan->tag, tag_len + 1);

A tag longer than the page therefore overruns the sysfs buffer. Under
the confidential-computing threat model, where the guest does not
trust the host, a malicious or compromised host can advertise a
~64 KiB tag; the first read of mount_tag (udev reads it at probe) then
copies host-controlled content past the end of the 4 KiB page, a slab
out-of-bounds write.

A tag that large can never be rendered through the single-page sysfs
attribute and is not usable as a real mount tag, so a tag at or beyond
PAGE_SIZE is at best malfunctioning and at worst hostile. Reject such a
device at probe time rather than truncating the value in the show
handler, which would silently break auto-mount rules that match on the
real tag. The probe-time bound makes the existing p9_mount_tag_show()
copy safe at its source, so the show handler is left unchanged.

Fixes: 179a5bc4b8cb ("net/9p: use memcpy() instead of snprintf() in p9_mount_tag_show()")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v3: Reject an oversized tag at probe time instead of touching the
    show handler at all, following Christian Schoenebeck's review of
    v1: a sane 9p device would never use a ~64 KiB tag, silently
    truncating it (as v1, and as the held v2 sysfs_emit() reroll both
    did) would break auto-mount rules that match on the real tag, so
    the device is simply refused. This supersedes the v2 sysfs_emit()
    patch, which is dropped in favour of the probe-time bound
    Schoenebeck preferred.
    v1: https://lore.kernel.org/v9fs/20260610114206.3749904-1-michael.bommarito@gmail.com/
    review: https://lore.kernel.org/v9fs/1962500.CQOukoFCf9@weasel/

Compile-tested (ARCH=um, W=1) on torvalds/master, no new warnings.
The original overflow was reproduced before the fix with an in-tree
KUnit driver under UML+KASAN (a 65535-byte non-NUL tag drove a KASAN
slab-out-of-bounds write into the 4 KiB sysfs page). With this patch
the probe rejects such a device, so the show handler never sees an
out-of-page tag and the memcpy stays in bounds.

 net/9p/trans_virtio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index b0d0094ec8e2c..15568f40509c4 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -633,6 +633,11 @@ static int p9_virtio_probe(struct virtio_device *vdev)
 		err = -EINVAL;
 		goto out_free_vq;
 	}
+	if (tag_len >= PAGE_SIZE) {
+		dev_err(&vdev->dev, "mount tag too long (%u bytes)\n", tag_len);
+		err = -EINVAL;
+		goto out_free_vq;
+	}
 	tag = kzalloc(tag_len + 1, GFP_KERNEL);
 	if (!tag) {
 		err = -ENOMEM;

base-commit: 4edcdefd4083ae04b1a5656f4be6cd83ae919ef4
-- 
2.53.0

