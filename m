Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221578;
	b=UBxc80P2xRSVmpnDS7rW0Xk3mC9pproEI7osXs8ZU4ciD/HZl7H+YjvCaUSfXZNUHOzL
	 tPepULNwR6kCGytoPDvKjy38IVx/x3wTOG5l6nol6ozFOspj0b1yFWp3B3ciP3v3Yte1U
	 devYR3r8k+vfycv3GMmItIG6xMeke6bzJf7fy8FIj0HPN3H9mLQI0Ws+HbYvhxWcSWa9f
	 k8RsTzZbuWV2NIjIwfmDkNrA4+3Zc6XuRkG6hNv5rmiCB4CeEGX5kc5fjGgM3xySwSLOP
	 l5k3Ths61YwP6XKk1z+BD0GakSYLYDb4ZeDalot4bkgYZU8j3hk3KRMTrcUp3J1mxXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1zQyQfd7Pg+TzVSNkwUE2q6hgZHqlG+eVtCLMd8G0fQ=;
	b=BLYRyglGfUz6I51YqkeXvJB0wnM2C1b2zJH9X/p83RFSI2pzCB9UKqxpqmSNYcV8J4/j
	 CvWX1U1kDBhTD5lmGUCinvGvvtL2D0hpeDLEogVeudj86ABaIq87+OY/PjO3hMx5eLlWX
	 NAE24aDuyRtDuu8vuWvNYJEtu3MWGjrRE9WQCUQjV67DJ0Ztw4C8Z8JFWzGOoY64CEusc
	 l3EFF1KFkX9K4OA+RN5oGojJvFtCeycqRLPLJlPpTSiZQnSfZqBJ/GauNvbcLkDeeYMGI
	 BKeUGjmlM2q6bjQjKggSYBb0ZHCiAtdaEvNgTOfX12CuxcGIxIHEip/L9gTmt7iYNcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b="cq6j/i1c";
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D42606A31C
	for <v9fs@lists.linux.dev>; Mon,  9 Nov 2026 10:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84D42606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=cq6j/i1c
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-14394530ec6so847966c88.1
        for <v9fs@lists.linux.dev>; Mon, 09 Nov 2026 02:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1794221576; x=1794826376; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1zQyQfd7Pg+TzVSNkwUE2q6hgZHqlG+eVtCLMd8G0fQ=;
        b=cq6j/i1cCDLfQWsQKHW3T84uRbuVcK2BdggTuU2S8PE1BtEh9nTucsxljBpp4dCjVc
         5uR8OYBPVu56pNlvjJXdQ50TkR6OshWTKaeGS4uQlqgfxBiPM4MBPgi+HwRzDfmKp1gX
         h06dS38L7nNcGx8twnkRYeMls7bn+pE8uiJnxpqKE/1Jtt0ZTmSvaimSJn2q+8ZXUVAW
         G9PQ43x9hvyYAvqPH72DDGUOoqlUFiHCMen6dn5asfHfQp0AHUcjtqhG5nGKjb6gJ4N5
         qqyX7gKzmOEXbGdE1nCw9lF/fH+kg/QEz2lb6b6xkva1g96hwyM8J5Q/tVj8zcJr7NbN
         jWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794221576; x=1794826376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1zQyQfd7Pg+TzVSNkwUE2q6hgZHqlG+eVtCLMd8G0fQ=;
        b=VHF2ST+UNJ+kmrF/2x6ZTSTORrSuDMbWeHHFmUmXxzLUGDutMsuUm9epuI/A6lD48t
         nYPDzIEu4x0ZYMWX6cMgyAWRV6Wy9U258gf/jBjY6sgZTMeNuRIx9cdDXNx4Yx+oRtL4
         Pd+gOUM7oq3Vk/IZ/2HRT9O4xl4uuPDNPSt37Gfq/r9O7LfN6qCT5IsElJpqP0LbjYC/
         FUuz41TOwqpeZv5V0JtzB1cYyxK+RjXSf4sm5vkQgyFloe3FJkVfnskM7H38I1dUXWSq
         BeG84XlpFW//WvFZxwOdO8KQcFPDVavntnn7ecMlRas0q7pEsLJTu/6IPfeGRMdsaIVN
         DTBg==
X-Forwarded-Encrypted: i=1; AL+hErFqQENWDU5T2UGl8PKVdtf4XQFxJ12B0iQ5BQFTuPvYDLhZ1evCvBveSAij7v4y90viRJ9C@lists.linux.dev
X-Gm-Message-State: APuU4Z8hW8LNIzSrqI4fRmS1X6Pk3vnhenry61QVlBitN/HXoh8z6jqW
	SBo5j0Do9FaKleoyoNCmKRd1X7Fy34Fw30WUvYNTsann0aJ1ZWL8BghZ2BxB5ojFSg==
X-Gm-Gg: AYBFou2qu3JJQ5xnMDc8tT8sDCS1fcs80PcA70MuMtPOKtIoDBsXEpZZocoDAI8sM6W
	TCA18NOuS967gwbZBUWfvbkOWXTgLZnuxmfwkj0jlmcGyUBQKbeLfawk+6/y6R7OPVaMD1XKGaH
	GvXWNSiMvyqofCE43t/PHEd0Y9KpSzCVDdC7cq2gHGG791O1RwuMXqySDrM+9KL/qEVO7tD+x6C
	m5scrPOwx/qyLQtSzBnJcPr7TpCfnx7VzMrtlF/Nr+yBbE+H7R90M9FDrivRRzT5NRFz5DJYH5I
	2zPXm6ClwgOnQF5bR4wOa05kZSZpMYfSMlkdx/wOBnfRb57GO7fmHUZv9dyK6UVTLJfdbsTPxAR
	8XTiFUEiaRtn/0SZGKT9MODCMQmAb6pwG1fkhtl+Fwc/d0jgEFr8BkmgT+UBJCFNGRWWuT8SiUq
	bTDMA722KTw/iq4aPfPjCkwzW3lxvLifFMVjnBlHvzCX0NqhwTO7D1Cphc6SIaoA+dGSqyIizl6
	+AKi8wztrBoSIgQUZDdxl8J8nprWIxiKTO3JXQwd+24FiMb5Om3JQG1eJ199tkGt4DKYVR+k65n
	igj6qgWzw+9Zn2KapHI79lSTX0LFyhSJGXV85Q==
X-Received: by 2002:a05:701b:464b:b0:1b2:6855:99ac with SMTP id a92af1059eb24-1b39ff1d913mr5044256c88.46.1794221576448;
        Mon, 09 Nov 2026 02:52:56 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375726fd1sm12228744c88.14.2026.11.09.02.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:52:56 -0800 (PST)
From: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Simon Horman <horms@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Tomas Bortoli <tomasbortoli@gmail.com>,
	Chirantan Ekbote <chirantan@chromium.org>,
	Greg Kurz <groug@kaod.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	v9fs@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>
Subject: [PATCH 0/5] 9p: bound zero-copy error replies and keep flushed requests until the device returns them
Date: Mon,  9 Nov 2026 19:52:46 +0900
Message-ID: <20261109105251.2545764-1-lian@is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.56.0
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

This series fixes memory errors caused by a misbehaving virtio-9p device
in zero-copy requests and in the flush of an interrupted request. A
correct device can also cause a double put, which is fixed in patch 3. A
zero-copy write interrupted by a fatal signal can also overwrite a later
write to the same file, which is fixed in patch 4.

The patches were tested with QEMU modified to send the malformed or slow
replies.

Lianjie Wang (5):
  9p/virtio: clamp the reply size of a zero-copy request
  9p: ignore a zero-copy reply that arrives after a fatal signal
  9p/virtio: keep a request until the device returns it
  9p: take the tag of a flushed request from the request
  9p/virtio: keep zero-copy buffers until the device returns them

 include/net/9p/client.h |   6 ++
 net/9p/client.c         |  19 +++---
 net/9p/trans_virtio.c   | 130 ++++++++++++++++++++++++++++------------
 3 files changed, 106 insertions(+), 49 deletions(-)


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.56.0

