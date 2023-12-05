Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD241401A
	for <v9fs@lists.linux.dev>; Tue,  5 Dec 2023 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="PLtCjPBo";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="PLtCjPBo"
Received: by nautica.notk.org (Postfix, from userid 108)
	id E3AB2C021; Tue,  5 Dec 2023 10:07:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1701767258; bh=Zcza2koUNlQSollLV/Bg+N9kW0zXA9vz++qJ4d4v5fY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PLtCjPBoN6k82Qh/P8T2TOhDgZvxpkF4U4kHR6pFz9b9ScBcRsgHpeLIzbA4YrCrS
	 ihetjFpGVvB0wwUEnrkRTotWZu8oWwiYfSGl1AtcsBOC+07aYbbaAsUyIEvfTVAUhQ
	 NQzWpdnEYr/f0V2iOmmagyCddECvEK7zofcknbkjksaBc/YwcVbZ5goUZCH4b7joia
	 hue6N17SNSCzzxEGyGEm58HBOXVoLYmp4eJVrOEjC4yt0vtQElwjV0Z2nJ6uBU+Uj+
	 AvJHZAyjctSbABrVdFp0KDUhFOeUlqs0GZbC3QQOaAmZqNIZUjPF2eUSaxibK0pWN8
	 hbv5Hp2nRmncQ==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 586B3C009;
	Tue,  5 Dec 2023 10:07:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1701767258; bh=Zcza2koUNlQSollLV/Bg+N9kW0zXA9vz++qJ4d4v5fY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PLtCjPBoN6k82Qh/P8T2TOhDgZvxpkF4U4kHR6pFz9b9ScBcRsgHpeLIzbA4YrCrS
	 ihetjFpGVvB0wwUEnrkRTotWZu8oWwiYfSGl1AtcsBOC+07aYbbaAsUyIEvfTVAUhQ
	 NQzWpdnEYr/f0V2iOmmagyCddECvEK7zofcknbkjksaBc/YwcVbZ5goUZCH4b7joia
	 hue6N17SNSCzzxEGyGEm58HBOXVoLYmp4eJVrOEjC4yt0vtQElwjV0Z2nJ6uBU+Uj+
	 AvJHZAyjctSbABrVdFp0KDUhFOeUlqs0GZbC3QQOaAmZqNIZUjPF2eUSaxibK0pWN8
	 hbv5Hp2nRmncQ==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 0564bc80;
	Tue, 5 Dec 2023 09:07:30 +0000 (UTC)
Date: Tue, 5 Dec 2023 18:07:15 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	v9fs@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] net: 9p: avoid freeing uninit memory in p9pdu_vreadf
Message-ID: <ZW7oQ1KPWTbiGSzL@codewreck.org>
References: <20231205080524.6635-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231205080524.6635-1-pchelkin@ispras.ru>

Fedor Pchelkin wrote on Tue, Dec 05, 2023 at 11:05:22AM +0300:
> If an error occurs while processing an array of strings in p9pdu_vreadf
> then uninitialized members of *wnames array are freed.
> 
> Fix this by iterating over only lower indices of the array.
> 
> Found by Linux Verification Center (linuxtesting.org).

You might want to mark that as Reported-by: somehow instead of a free
form comment

> 
> Fixes: ace51c4dd2f9 ("9p: add new protocol support code")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

That aside, it looks good to me -- good find!
I'll push this to Linus with the other pending fix we have next week

> ---
>  net/9p/protocol.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/net/9p/protocol.c b/net/9p/protocol.c
> index 4e3a2a1ffcb3..d33387e74a66 100644
> --- a/net/9p/protocol.c
> +++ b/net/9p/protocol.c
> @@ -393,6 +393,7 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
>  		case 'T':{
>  				uint16_t *nwname = va_arg(ap, uint16_t *);
>  				char ***wnames = va_arg(ap, char ***);
> +				int i;
>  
>  				errcode = p9pdu_readf(pdu, proto_version,
>  								"w", nwname);
> @@ -406,8 +407,6 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
>  				}
>  
>  				if (!errcode) {
> -					int i;
> -
>  					for (i = 0; i < *nwname; i++) {
>  						errcode =
>  						    p9pdu_readf(pdu,
> @@ -421,9 +420,7 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
>  
>  				if (errcode) {
>  					if (*wnames) {
> -						int i;
> -
> -						for (i = 0; i < *nwname; i++)
> +						while (--i >= 0)
>  							kfree((*wnames)[i]);
>  					}
>  					kfree(*wnames);

-- 
Dominique Martinet | Asmadeus
