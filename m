Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23EC36494F;
	Fri, 29 May 2026 03:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024180; cv=none; b=JpJkWh5uYZEQqNV9udJE/kHbDYru/be6Aa/pPot8i2ntU4a7WYu0XyEZQYuIAXh8TdwA68YVUKspGNr1PyLo3Er/dQi6QPJ95w8/p+7bkhOa6SrlwSf1OsU9j35GD8KbrEQ2SsQCWqhrDGdOSb/CKCsFareI6gyCwl7dnJgzEwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024180; c=relaxed/simple;
	bh=pFaTjHYEVPK6BiO7PWHOivez3UE0vsQ9STSaCCz5gEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mv7z0fKDgbS3vmnzMthVHVAJMdluyXiLMYjyB5DevDAVYejKKtWjda1fZKcvNuTjRBFhft9fgwh4KBkaF5Ww/scn6zd98SpzqtBs5Sg/KkUUTyZjzBfp8cJNgZ/H3Ms+kr4OI5gOFfdbzGdkiC3Zy0fdpW7NtaOuqs2JGqFXsKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhqTYos9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhqTYos9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7756CC2BCB4;
	Fri, 29 May 2026 03:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780024179;
	bh=pFaTjHYEVPK6BiO7PWHOivez3UE0vsQ9STSaCCz5gEk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=lhqTYos9fLE1pqYG7Q88DgfR5Y/sUYKDWoTc43vDwsVV7TSf2EAFHU1SCtPsm/0aS
	 9O022CsTyOLtacjuUCEPLkBnSBYZbgnwRXmqsUUfwCuaqNLxykEST4tcLP5+b5BEj4
	 Pm3hTeC61+EurOpw4NvOh2QYNE0jM+cdNlNVu8EOJGrS8zqw9oQw3OuuvS7gUG7VUe
	 MFgBIAkV9bnuOFaQVt/YHQhlz7wqnrm62zPOZQWFcEVF0On131vWG58q0g7gevBKYN
	 JfsRwuJxcvlOIJ1TUdG9YJsL8iIhB3FNbyg5HpP+VXlVpaMhDeEnT0XDf0qO7ixHBZ
	 r+8ucraEMgfKw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6096ECD6E49;
	Fri, 29 May 2026 03:09:39 +0000 (UTC)
From: Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>
Date: Fri, 29 May 2026 12:09:20 +0900
Subject: [PATCH] 9p: v9fs_file_do_lock: replace WARN_ONCE with p9_debug
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-lock-warn-v1-1-20c29580d61d@codewreck.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyNL3Zz85Gzd8sSiPN00A0OT5MRky6TElBQloPqCotS0zAqwWdGxtbU
 AeC/07VsAAAA=
X-Change-ID: 20260529-lock-warn-f014cac9badd
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Yifei Chu <yifeichu24@gmail.com>, 
 Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=4/mZa49DWHG6WAg/Twqmw7YhHfcEeqma4x3bjMrCRog=;
 b=owEBbQKS/ZANAwAKAatOm+xqmOZwAcsmYgBqGQNugTQrakmwajTIPUO5RKczOvfdgPSn6C00k
 Hi4PuivyqyJAjMEAAEKAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCahkDbgAKCRCrTpvsapjm
 cAVZEACnitp9Z31dzO9xeHzYzeLbOaIb9qbb1/Sz1wz8cosuoMNifBnBHQH+TUGOcnKwMMNLSf4
 mDqJMJEEn1B7rJl/os7fEAtrz8MqZAB34/U0wABJPpq/PP3OoMe3ulyk/cjEdCfsFlwtypuhuGU
 WZCsQJPOLT9ZDArdoDV0IZR+fY14rbeuWt2fGEQPTfDrbhCvzw06QZlw3SNxG8uFHTqySFot/eI
 L5JX+ITeKEUrv9VpuNkDesrskFKd6F12N/uZHRTwmplH7IpoHwi3i86ZwLBYdAm99L8zm6CUu2A
 w5diBxwVVDJ0mZptR+mOlc5okQUEN7aaWQU/QewbKtH80TMvaiV1ds+EyLD7mjg8o3qB9F+vLK/
 E4qEWEf1Yx+XXlv1/jyX2OwMadtj5YHwy+RSsqhg+tvugekYGKcjDye7WaEiJptwdKxC5WCIaEX
 /69x7Apj6SccANfBj/ye11Px3pFvArBWYgssWlaaat+gIYwylCzQ7rXoqU9zZy7kK7amCT2evLS
 SWsIS/R2SP0TqIouz732rb9ClpupKbzTR8OIyHXXXmzemIlRwWZ8wwAozSrtzZkdzS1a1mPhmjc
 WYNQBytmfNuBrD4MuBFGSbxfBGTZzgD0e7ZzC73jrlxCOcvVePFyG2t8GUD1BGQjTojqXD1pY0k
 8LEkE+dXuux/cUQ==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A
X-Endpoint-Received: by B4 Relay for asmadeus@codewreck.org/default with
 auth_id=435
X-Original-From: Dominique Martinet <asmadeus@codewreck.org>
Reply-To: asmadeus@codewreck.org

From: Dominique Martinet <asmadeus@codewreck.org>

This warning depends on server-provided data, we should not use
WARN here

Reported-by: Yifei Chu <yifeichu24@gmail.com>
Closes: https://lore.kernel.org/r/CAPJnbgJ7ZK7DCjCfG56hd_iKGePmAzudb4hOWd4=9r32nM+KcA@mail.gmail.com
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 fs/9p/vfs_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index c5e73c37baea55394294b939fdda7170db8503c0..cddfb4b7ce4e22aacad7b51f6e6cbd164b7c2f8f 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -198,7 +198,7 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 		res = -EAGAIN;
 		break;
 	default:
-		WARN_ONCE(1, "unknown lock status code: %d\n", status);
+		p9_debug(P9_DEBUG_ERROR, "unknown lock status code: %d\n", status);
 		fallthrough;
 	case P9_LOCK_ERROR:
 	case P9_LOCK_GRACE:

---
base-commit: 3ec9e935015b11236ba778885d89e399f00d6b50
change-id: 20260529-lock-warn-f014cac9badd

Best regards,
-- 
Dominique Martinet <asmadeus@codewreck.org>


