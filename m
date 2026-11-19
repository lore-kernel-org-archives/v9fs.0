Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795078063;
	b=CdI882sHiQLjh+7QjwcjU3r2Zsggd9MB9J6fZXNTdjNQGk5HJGilKxCmvI31gJBTwnAT
	 OVb/WOsldxy+5hXXjOek0LaDIwkoLQCMDigybmK9rYncFv0YCHtdtgTfMcd+thMC9K3l7
	 CoLsqqhJSegsyIfBBRz5uz7YhGSVvcPYlBA2dz26UUnLNg5t/8WdsdFWKSj/AvSoDCARI
	 rlt22gjZ49CYOo+d9zRHuheQQIq+K7B0cyC5QumE4dpmfIcIIuE/hhR3JG6RQcCcW9BS2
	 2+7JltbfGN07UHjGsHs3u5KtwMTpxUC8hBN6CwklL1PLpid4M+hm388/Q3beGKUEFNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795078063;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Hxi5SwjZv7XKtF4E+VkyhO+WlvcrVy0lIGzVRgkW3tk=;
	b=d5saQLb21DCwI5wxQZjpROwS1XStoG0cR+b5SjtyS3Yn8z8x+od2TzoY3zDDDZFJTM5H
	 wY2I2JHBpBMn++mB4KM7RbBHEpyKhARdi2CzTfL9SRgeKxAVLx0c2PFRaZrsZNpnMA3zh
	 TTdqiGL6XF5H3AoVzZY1mNU9MyTtolU8EovDmO/DbosdKWPLBy7itlWRtTGTCgE/GgCRL
	 IN4PJHqxuoCbSGDd3QyEovqY/eCyLORmWXO1Aac/3RBfYh2dXQUy5SanoaxUGvfhu+WXW
	 GN7rG1HWUPR+18ig02UD30EFvY9/kAfG3t1Pi/g15od2yZbEoSTcMj5jfcXBbNafwiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dxZqAMnf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA496606A320
	for <v9fs@lists.linux.dev>; Thu, 19 Nov 2026 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dxZqAMnf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428A81F000C4;
	Thu, 19 Nov 2026 08:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795078063;
	bh=Hxi5SwjZv7XKtF4E+VkyhO+WlvcrVy0lIGzVRgkW3tk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dxZqAMnfrxcW4N+kKOrVk9FxJwb1TpL1uWgY5YsDt9eV02gbMguI3RdS39nHHXnRX
	 eEEmdyCV3HHzhTbTYEYVL07ppcoPPyXmXirXql/LIPl5fikcJnt4MQ6GxoVJ3ONgQj
	 E84X+wsqHo5BzzddrycG4dqjI/XKBdDcJE1fIvWaHPBuX8bXoakH8qx9gLl2wlnFW7
	 CYTz6vDzVLIdyjpIDPkfiFPYIg93Z1P7Ck0hUqE3KODxzl316uDhiZc5lo92yVLvqO
	 TjjgZald75vDaeVFB69IYY1WQj4NSeKCvHWNVA+fX2ZpLNCXRsgGnTd3V9Zjsk9krr
	 4GYFZaNwGB/uw==
Message-ID: <sashiko-outbox-222712@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 01/17] iov_iter: Fix kunit test to remove __init and
 __refdata marks
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
In-Reply-To: <20261119083851.3306418-2-dhowells@redhat.com>
References: <20261119083851.3306418-1-dhowells@redhat.com>
 <20261119083851.3306418-2-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 08:47:42 +0000
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Post: <mailto:v9fs@lists.linux.dev>
List-Help: <mailto:v9fs+help@lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:v9fs+owner@lists.linux.dev>
Precedence: list

> Remove the __init marks from the functions in the iov_iter kunit test so
> that they don't get removed after the module is loaded or if the test is
> built in as the tests can be triggered through debugfs too.
>=20
> Also remove the __refdata mark which is unnecessary if the table so marked
> doesn't point at any __init funcs.
>=20
> This was found by claude-opus-5-5 run locally.
>=20
> Fixes: 2d71340ff1d4 ("iov_iter: Kunit tests for copying to/from an iterat=
or")
> Signed-off-by: David Howells <dhowells@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119083851.3306=
418-1-dhowells@redhat.com?part=3D1

