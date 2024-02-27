Received: from mail-40137.protonmail.ch (mail-40137.protonmail.ch [185.70.40.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3839F2557F
	for <v9fs@lists.linux.dev>; Tue, 27 Feb 2024 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709053374; cv=none; b=Wdy7Kj03K7yEVXiZSvXWM6hvdmI8Qm1ncFEp8sb95ugUN3kt7JY1G08CbLt9UdCzQlT+FLfhob0OUVJVYrNrTiB0fghXOMzf0MS7n1gyUwl02OvKDVx+P6Sn5Tt2lgJ13E1weBmwQ5Bks83vXi/q1JpGdRGG/FvZ/hVqRRxIPik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709053374; c=relaxed/simple;
	bh=vkGgUHR1fNIIKPwhI9EiYuGgq3XC6I/Z21vd5j1m5Gg=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=mLBRdjr4cranqebcsR7N06MU7p240RxhaKnUjpCmTQUHaFHWX2Yh4wGpRwMz+vTRTvkIp1WVt8o6IfKhF5nQ0o9IQaxdaCAAt8LJO06hdm9+OUQcdw01JRoqdNb1mzNpjz1WPtBZQuO9gNromnFQAsDZ0G1ojIXYugdXd+mQalY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=xwqHEp9t; arc=none smtp.client-ip=185.70.40.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="xwqHEp9t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1709053369; x=1709312569;
	bh=vkGgUHR1fNIIKPwhI9EiYuGgq3XC6I/Z21vd5j1m5Gg=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=xwqHEp9t+6fK9izJNUoltYHpG6UGFCWzmrRZKrS3cxTDlqOi6ZJtivkl8w7hnkCLo
	 woz6+2WgzxnbxQ+6kI2oKjyl72Evy9BOmvBAmYuFUy2fJugdV28RHCBiq5fZS0hWpn
	 UqWbMZG3LD6OUz84R46XjMV5vn1lidtuSvNbTKzPXcnJxdkGURym8x2g3gCtH7WwXj
	 8CJJTNUAgV02ZT802JNudJZK/tk9t35mhr2bP0uEIcX0whrbtFK1o7rbWxzSlZTMUa
	 gC+u6p5xJ+wUvxs5YuA6MHxWmwmo27Bg7L6w57Ty+ehMitLdHq/RnBtPiDfnA1Zi8+
	 qrwtC5aQDjGCA==
Date: Tue, 27 Feb 2024 17:02:23 +0000
To: "v9fs@lists.linux.dev" <v9fs@lists.linux.dev>
From: rfamm <rfamm01@protonmail.com>
Subject: subscribe
Message-ID: <NrOGysAsCV2F5OJ3hFqByJPm4v6gCiAYAFZuicygBeC3zVrlGpZa9nkxRrq7HIvIow8IaJmdeZNJJ6lef8dMb6ToGlaFsEKyUreFnA372zM=@protonmail.com>
Feedback-ID: 101221344:user:proton
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


subscription request
