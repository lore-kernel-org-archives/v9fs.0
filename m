Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B34B1482F0
	for <v9fs@lists.linux.dev>; Fri, 23 Aug 2024 08:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724401823; cv=none; b=KDbqGlNHQwpyHFBTgRhvSXMCOMc6ErI/3OwJQoUMe3Ep5HuiAhKfXqToHgzAncwragpDItptxRqUb22TDTaYzQZx4ZGmc3ga1HM41/fqDgiavlk0JPhdIrlcC0hDR2qUOVhI77n5+yPL/G098UFlR5F78DJqeufS8YtrUl4kIt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724401823; c=relaxed/simple;
	bh=rjhxv2t08DqDPHrpZk4YuwYWEvtkeDRepg3q6RjCzuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZqzxw3CupsZfxsWGFOjnA0ut0P06owOZgcAkIU5NQ/Z0D9esF+eu7dvtqHbygK6iD5mloK/g3HVFjFd4JMyoB8RfLUuIvnRWOvZIbJ3PGhFzWAf5kKO5PTZzVczBU434vkr9D1Jc6IGviyhr3FIO+SEG9MN2oxnfkWpjCIyhVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=G5ArijfC; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="G5ArijfC"
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id hPgQs5jfklL4ChPgQslxTp; Fri, 23 Aug 2024 10:30:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724401813;
	bh=PVjp2iT7Rv5Qx8ZjmxlWjeR6rEVd8j+mpByLlyhusHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=G5ArijfCIVlkKAf0/dr6MVHi16pv+N4Xqm9v8RokEFBcnN6xgA/Y99dF+91nx2w3b
	 2oZ1RPyiPUtmxBGnaoy+Sroi5Jl7Qh2VzM3RIMjHz6G7tlrkDQ8CyJ2LspNXx7JV5n
	 qxEY6aJN0aj3jgUgzdFNQzC/A/3su96UoWskA/uO87EZh3g0oGakjmQO2u413Vk12k
	 f4joFWK2HpqqOMLdmLrPtrxIi6UKpmHMff8TWZ8Q+dhpJxl8yuQM+VpSZ6TQcbfGz/
	 xkZAMVBzkFs9S9cBPeT+naNtkj9lI7mCIDgBWPN3GjCbTCj0VNaHEzBDM/GQS7v2EZ
	 HZwGf4I6pzCcg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 23 Aug 2024 10:30:13 +0200
X-ME-IP: 90.11.132.44
Message-ID: <5fce67e8-5687-4fde-b6ee-b564a335283e@wanadoo.fr>
Date: Fri, 23 Aug 2024 10:30:09 +0200
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/3] usb: gadget: function: move u_f.h to
 include/linux/usb/func_utils.h
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: andrzej.p@collabora.com, asmadeus@codewreck.org, corbet@lwn.net,
 ericvh@kernel.org, gregkh@linuxfoundation.org, kernel@pengutronix.de,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net,
 v9fs@lists.linux.dev
References: <20240116-ml-topic-u9p-v9-0-93d73f47b76b@pengutronix.de>
 <20240116-ml-topic-u9p-v9-1-93d73f47b76b@pengutronix.de>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240116-ml-topic-u9p-v9-1-93d73f47b76b@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 23/08/2024 à 09:36, Michael Grzeschik a écrit :
> We move the func_utils.h header to include/linux/usb to be
> able to compile function drivers outside of the
> drivers/usb/gadget/function directory.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> ---
> v8 -> v9: -
> v7 -> v8: -
> v6 -> v7: -
> v5 -> v6: -
> v4 -> v5:
>    - renamed to func_utils.h
> v3 -> v4: -
> v2 -> v3: -
> v1 -> v2:
>    - new introduced patch
> ---
>   drivers/usb/gadget/configfs.c                              | 2 +-
>   drivers/usb/gadget/function/f_fs.c                         | 2 +-
>   drivers/usb/gadget/function/f_hid.c                        | 2 +-
>   drivers/usb/gadget/function/f_loopback.c                   | 2 +-
>   drivers/usb/gadget/function/f_midi.c                       | 2 +-
>   drivers/usb/gadget/function/f_midi2.c                      | 2 +-
>   drivers/usb/gadget/function/f_sourcesink.c                 | 2 +-
>   drivers/usb/gadget/u_f.c                                   | 2 +-
>   drivers/usb/gadget/u_f.h => include/linux/usb/func_utils.h | 2 +-
>   9 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
> index 0e7c1e947c0a0..0f8553795a8ed 100644
> --- a/drivers/usb/gadget/configfs.c
> +++ b/drivers/usb/gadget/configfs.c
> @@ -8,8 +8,8 @@
>   #include <linux/usb/composite.h>
>   #include <linux/usb/gadget_configfs.h>
>   #include <linux/usb/webusb.h>
> +#include <linux/usb/func_utils.h>

Hi,

Here and in the other files, maybe, keep alphabetic order?
(even if it is not already completely sorted)

>   #include "configfs.h"
> -#include "u_f.h"
>   #include "u_os_desc.h"
>   
>   int check_user_usb_string(const char *name,

...

> rename from drivers/usb/gadget/u_f.h
> rename to include/linux/usb/func_utils.h
> index e313c3b8dcb19..9f2a32c765260 100644
> --- a/drivers/usb/gadget/u_f.h
> +++ b/include/linux/usb/func_utils.h
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * u_f.h
> + * usbf_utils.h
>    *
>    * Utility definitions for USB functions
>    *
> 

Maybe the include guard could be updated as-well?

CJ

