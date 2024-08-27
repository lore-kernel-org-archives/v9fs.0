Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DCB1C6896
	for <v9fs@lists.linux.dev>; Tue, 27 Aug 2024 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777213; cv=none; b=d5G1supPv1PjDe1WhYRXbQXLx4oIFb1HxqSJwQhEQnPHM5WCK3wi83CeZI9JUkj3W3/Nd/2IgXMawQqOpbYRSENOyL8Vy48/YpbzudfwEP7kUhGjMlJb6aG0aTE6b8Il3KMt2VyJK5Bl9P76/w37U/xE8xje44NAekWP8sf0TQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777213; c=relaxed/simple;
	bh=3coVSHnIL3mcFgBlCaZMNE1Znm3p3w7qZxfk/mb4L60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cf0PVUOnfT0jR9XrOZjuA+zLu7FOPh2gyoxm4yVUfwf7FlaEb2kmRVGmWp1Coc1d/Fk1jGx9RPEiSFc9kz0My4kqDm57PwjY1OXGz1gDtUpnRBu6/ctU36V3xIVgCQQmq9tscKRutQGGqHvqOn1Slv3KeOvQI/QP1yQT37h1/jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=jYIALnwn; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="jYIALnwn"
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id izL6szCw6aOqrizL6s5dis; Tue, 27 Aug 2024 18:46:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724777203;
	bh=HEgEh0iFiHmIlNjHfnI14kSxb/5CvpiTukzOm6OLqco=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=jYIALnwnoc/Fqyg9xaDUasFMC3qAhVc1IEHtgV+zvCHQ1XoEIl2EWEIT8e3puA8Sx
	 wKkt2hJeMDibWHVt1JChzqWmVAuqi37IM9Oj+k7Qh6SjzxKlr5Su7g6O15Ydkl02/+
	 ZRZyqnq9I9XkDBxY5BEIH9R6l8pc7iRFCM71Jk8JO5dNHzMCMuXtcQTa/+uxlPr662
	 zrKLHRNJ/Aw0kRBZHt/GHRJiFwY57fiNW+bjwYa54s+dKYSn2hxojRjQbxqGjMMHbs
	 PldyYaTMalZacDZFZcNuj9zWG6vIRl1+U2bQ6KwIVHjsF0c64m2DFo+O5RzyFEXdZv
	 EAtrhVeZDfgGw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 27 Aug 2024 18:46:42 +0200
X-ME-IP: 90.11.132.44
Message-ID: <1a5d3a68-56e5-4084-b86c-e60542cbbb98@wanadoo.fr>
Date: Tue, 27 Aug 2024 18:46:39 +0200
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/3] usb: gadget: function: move u_f.h to
 include/linux/usb/func_utils.h
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: andrzej.p@collabora.com, asmadeus@codewreck.org, corbet@lwn.net,
 ericvh@kernel.org, gregkh@linuxfoundation.org, kernel@pengutronix.de,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net,
 v9fs@lists.linux.dev
References: <20240116-ml-topic-u9p-v10-0-a85fdeac2c52@pengutronix.de>
 <20240116-ml-topic-u9p-v10-1-a85fdeac2c52@pengutronix.de>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240116-ml-topic-u9p-v10-1-a85fdeac2c52@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 26/08/2024 à 23:47, Michael Grzeschik a écrit :
> We move the func_utils.h header to include/linux/usb to be
> able to compile function drivers outside of the
> drivers/usb/gadget/function directory.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> ---
> v9 -> v10:
>    - respect alphabetical order
>    - correctly changed filename in func_utils.h itself
>

...

> index e313c3b8dcb19..e7b69e3145c07 100644
> --- a/drivers/usb/gadget/u_f.h
> +++ b/include/linux/usb/func_utils.h
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * u_f.h
> + * func_utils.h
>    *
>    * Utility definitions for USB functions
>    *
> 

Maybe the include guard could be updated as-well?

By include guard I mean:

	#ifndef __U_F_H__
	#define __U_F_H__
	...
	#endif /* __U_F_H__ */

s/__U_F_H__/_FUNC_UTILS_H_/ or something like that.

CJ
