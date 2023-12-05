Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82C25D8EF
	for <v9fs@lists.linux.dev>; Tue,  5 Dec 2023 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="r5l5QQB/";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="r5l5QQB/"
Received: by nautica.notk.org (Postfix, from userid 108)
	id D635BC01E; Tue,  5 Dec 2023 13:43:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1701780233; bh=9k2hEUfWqSwjsOCNxJeHa/J+KeqtpWnpfnSOvtCRoqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r5l5QQB/eieudp+PT4SYxj+jH20QiV6viRJce+pCsKIvdchAaSSo6NJrm8mbpX077
	 4FfxkWQ1sekeWcSekEviSIJyQz6pPS3ChXg/kZtOFoWvFUV214ioLcZ3ymvXOOEFLq
	 TFdGCULG3GMJQkCbiNgoSAqnxxJ3Ula5kL07YimK58QyKTqWpFU8zR+2JHu0jHIKqu
	 QA7P8uGIOdPCs/vNM+ym0SuZlWDPdbLE5D+Cqwyr+JYnE+ofu4z9wcAaV00YcwQJ1l
	 R31riyGsVI5wQdTKV90vNKG1rZwuhw8h67zc4qzlX7UPuI5eSg1AF0Nwwfc70vv8Pw
	 9eWMwT5UxDIsg==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 79FDEC009;
	Tue,  5 Dec 2023 13:43:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1701780233; bh=9k2hEUfWqSwjsOCNxJeHa/J+KeqtpWnpfnSOvtCRoqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r5l5QQB/eieudp+PT4SYxj+jH20QiV6viRJce+pCsKIvdchAaSSo6NJrm8mbpX077
	 4FfxkWQ1sekeWcSekEviSIJyQz6pPS3ChXg/kZtOFoWvFUV214ioLcZ3ymvXOOEFLq
	 TFdGCULG3GMJQkCbiNgoSAqnxxJ3Ula5kL07YimK58QyKTqWpFU8zR+2JHu0jHIKqu
	 QA7P8uGIOdPCs/vNM+ym0SuZlWDPdbLE5D+Cqwyr+JYnE+ofu4z9wcAaV00YcwQJ1l
	 R31riyGsVI5wQdTKV90vNKG1rZwuhw8h67zc4qzlX7UPuI5eSg1AF0Nwwfc70vv8Pw
	 9eWMwT5UxDIsg==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 98847857;
	Tue, 5 Dec 2023 12:43:47 +0000 (UTC)
Date: Tue, 5 Dec 2023 21:43:32 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Latchesar Ionkov <lucho@ionkov.net>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	v9fs@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] net: 9p: avoid freeing uninit memory in p9pdu_vreadf
Message-ID: <ZW8a9BvNwO4yw_JX@codewreck.org>
References: <ZW7oQ1KPWTbiGSzL@codewreck.org>
 <20231205091952.24754-1-pchelkin@ispras.ru>
 <ZW7t_rq_a2ag5eoU@codewreck.org>
 <2974507b-57fa-4c9b-a036-055dbf55f6a4-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2974507b-57fa-4c9b-a036-055dbf55f6a4-pchelkin@ispras.ru>

Fedor Pchelkin wrote on Tue, Dec 05, 2023 at 03:15:43PM +0300:
> As for the second initialization (the one located after kfree(*wnames) in
> error handling path - it was there all the time), I think it's better not
> to touch it. I've just moved kfree and null-assignment under
> 'if (*wnames)' statement.

Ah, I somehow missed this was just moved; that doesn't change anything
but doesn't hurt either, sure.

> The concern you mentioned is about any user that'd ignore the return code
> and try to use *wnames (so that the second initialization makes some
> sense). I can't see if there is any such user but, as said before, it's
> better not to touch that code.

Yes, it was here before, let's leave it in.

> > I don't mind the change even if there isn't but let's add a word in the
> > commit message.
> 
> OK, will do in v3.

I've queued to -next as is (with the i initialized as Christian pointed
out), will update if you send a new one later.

Thanks,
-- 
Dominique Martinet | Asmadeus
