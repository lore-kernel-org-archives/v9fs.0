Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459705674A
	for <v9fs@lists.linux.dev>; Mon, 11 Dec 2023 23:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="KnGMPzpA";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Odnq8u7w"
Received: by nautica.notk.org (Postfix, from userid 108)
	id 0F892C021; Tue, 12 Dec 2023 00:21:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1702336918; bh=RctkjfZ/uke+J5C79Z3MVEHpAx1sc8x3waMFXiBIDT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KnGMPzpAELr8JjpS95nwnrdE32aZoKtU3/ayhbsMfwA+gytZZAufIFQBqESDVNwGT
	 dfeIu9kJcxr5d6uoOoHuFjAbgLfDyjtazXyfULGlz7V0so8Lr6ll5Akc+TeSYLnXc2
	 wEbEgdO20VPBAuTk4P2dM3teSAnOcP1V2sAQSOojPToNSBZwUtb08ubD95Q1wZp6nN
	 QTUpX6hKW6I2Tb7a6AewPjZvz9bSBrNzzxd9xMpnni0grJ8t1Wxc6ERaxGqJ31kmUy
	 F6xwYZ+lQa1xbUBvVb2Zpyr8IYH82c//k6GZo08ovGo3BU0Oe/zrg09XqhDJz2sDJE
	 KdlnFJUJQfsNw==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 82DE3C009;
	Tue, 12 Dec 2023 00:21:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1702336916; bh=RctkjfZ/uke+J5C79Z3MVEHpAx1sc8x3waMFXiBIDT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Odnq8u7wg88pa7i3Cw+3L4vmH+F6XkDUyoXumbgLwUo0ceDH5mmCZKmL+hTZvzKe5
	 8bAGrTyAen597zv7HoUof6QTJhO05gha1cqezTNsi1RdU/ogMJaPdnYUZdySGfCApi
	 fK3f9zVZGAVCVWOh2f70vqExnq1KfWQFQAskQnWYbfY+Zr8pTllIw42f7iPg3qdfVI
	 Ed/m06uM6UwZdHHIIodZBe1uekJO/U4+jBw5N4h0YLJDb7WcPNhkfRjXw81x+Xj2IN
	 uijtgLj1G550fCAoVd8OgoO+5cFpjGaZHNGoIDZy0+ETkig9erb0BiOGNkLtrG9VIt
	 occqrp8xWhEuA==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 4e583e84;
	Mon, 11 Dec 2023 23:21:45 +0000 (UTC)
Date: Tue, 12 Dec 2023 08:21:30 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	v9fs@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v4] net: 9p: avoid freeing uninit memory in p9pdu_vreadf
Message-ID: <ZXeZevFb1oDvMFns@codewreck.org>
References: <20231206200913.16135-1-pchelkin@ispras.ru>
 <1808202.Umia7laAZq@silver>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1808202.Umia7laAZq@silver>

Christian Schoenebeck wrote on Thu, Dec 07, 2023 at 01:54:02PM +0100:
> I just checked whether this could create a leak, but it looks clean, so LGTM:

Right, either version look good to me.
I don't have a hard preference here, I've finished testing and just
updated the patch -- thanks for your comments & review
(and thanks Simon as well!)

-- 
Dominique Martinet | Asmadeus
