Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1551E3219F
	for <v9fs@lists.linux.dev>; Mon, 22 Jul 2024 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721638196; cv=none; b=sntKU5lzrC97aEoGdv5C0LrR9cCrj2QGNdgIVrWlZNg6PbetEJrbdYzEZOLpjZUfLvX6wlP1zhPfNqR7DfvOW3X7/u/XpW/e9m4Dgo40EIkHRkHGheUToIT/Iy1e8vcz0ZbmtEVEG5aWcLMyy+AdAuOsexgARY8x7xMtnUUOAoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721638196; c=relaxed/simple;
	bh=47VPo2UorIlNZcLnbJEBEqv9wf0h06RjopgrPHwuUC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKK1jNQGxX5lVEf/MZ05OvODrR+ZjeZhUsHRsAlkNG8Dncne/a7pH9WG4Lu7BTsBD22SkV+TThnaDgRskg3wlNLX8cnRevF8UaCb2QUJrFwGG1QJw9GmY1FXFHivi1+TV6BxDz5lLRUul9S9qdGOXz8qbwppiw0DChxYiccwE4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aVDZH2Uk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aVDZH2Uk"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-427b4c621b9so26592355e9.1
        for <v9fs@lists.linux.dev>; Mon, 22 Jul 2024 01:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721638192; x=1722242992; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ow+3TiyVj0GJ9511ydtr5o2dgkAgB9VcYLqHCc+aPiQ=;
        b=aVDZH2Ukz9sP/Fl8KOQ/nkUUms3A/hfXAHzJ5dESSXEk4Z9kFBk3au39aAXsc3ReKr
         PZXTuFhV2qonL0gGtBL1Bbli75SB/ykjGAbuOv4sRfM4EYiMqyFgEuxLkM6eTkQV5vQo
         9C4lu8E9jsIx8VT89yhexQWcs4rjiv/UmEAqYAbMAzTssl551PQVdMGq1G9qq6W3dsuo
         N+hhzs3q3atHKXPf0j3KhBu84veVBs1apUcrnI2esCB/OJDNfEiu7mLiyEMASR8gnsMO
         qhfuAUfJjG810xoxCM0hOp5gh0cbjpBHTFTKOeTgXqyfXzBE4Mk5lNLxRUaEyoCIsENR
         Bi2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721638192; x=1722242992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ow+3TiyVj0GJ9511ydtr5o2dgkAgB9VcYLqHCc+aPiQ=;
        b=pQeBLd6EpF4bn3qDVbgy6cxg5O4XoizWayIq/ERXVYylCdm2ZX2Tk9DYJqNzgczfks
         /9mnOdEkGeuJ80pWru0YqMuPNE1YAyczWh/TGSHAAnY/BIUT7zIyuzpG2j5WJkz3hO3H
         uuYrL5l24kbchXw739k7PAhM0TZKChyZXKttaU2ZJw5a0ZnQJhSPMdxIQE4q3PMbfzjT
         q1S1tf/oJeldh4a3FgIudsIcR87Q5QV1qUttjLYQDOlUtnIShxbTTBj4faBzPFXHRB63
         d1SicODP4HjFOy4mjQbOt/dn7zJG4VjjiwY2fOGMirhjoV2BPuvMzLlqTplNljb8XL80
         6IYg==
X-Forwarded-Encrypted: i=1; AJvYcCVU4vMel+JBmzNF/+NMnpanU3KwXl8UPgclzI5jJS95TZbGYAfYJaU1SOUd0Kq7bifl+2Op6t+7OCGNep61Q2em0+jeJA==
X-Gm-Message-State: AOJu0Ywy45R90riYUMH7hNEfMDONDxYRlaT1Xch6rZbUXLCN5YpATOXm
	Zr/dwiaj43ym8sMLfqB1q/UBnn8hPbeNWiag4fyAKgMuXUiEG2tOp/HJewB/4VE=
X-Google-Smtp-Source: AGHT+IEV6ZArP3dSMTn33w6BUO0/tULLfdMjg6DA7wmDUW0v+Jzor4zkYN97P4gu9T/Bns/QI18YWA==
X-Received: by 2002:a05:600c:4f0c:b0:426:5f8f:51a4 with SMTP id 5b1f17b1804b1-427daa2815cmr36000095e9.12.1721638192233;
        Mon, 22 Jul 2024 01:49:52 -0700 (PDT)
Received: from ?IPV6:2001:a61:137b:5001:be5a:c750:b487:ff1b? ([2001:a61:137b:5001:be5a:c750:b487:ff1b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d6902a1fsm116372845e9.20.2024.07.22.01.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 01:49:52 -0700 (PDT)
Message-ID: <82f03be5-b8b1-4df2-8b4b-0cae5d6d67ba@suse.com>
Date: Mon, 22 Jul 2024 10:49:49 +0200
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] net/9p/usbg: Add new usb gadget function transport
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>, v9fs@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, kernel@pengutronix.de
References: <20240116-ml-topic-u9p-v7-0-3a1eeef77fbe@pengutronix.de>
 <20240116-ml-topic-u9p-v7-2-3a1eeef77fbe@pengutronix.de>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20240116-ml-topic-u9p-v7-2-3a1eeef77fbe@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22.07.24 00:08, Michael Grzeschik wrote:

> +
> +static int usb9pfs_queue_tx(struct f_usb9pfs *usb9pfs, struct usb_request *req,
> +			    gfp_t gfp_flags)
> +{
> +	struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
> +	int ret = -ENOMEM;

No need. This will be overwritten.

> +
> +	if (!(usb9pfs->p9_tx_req->tc.size % usb9pfs->in_ep->maxpacket))
> +		req->zero = 1;
> +
> +	req->buf = usb9pfs->p9_tx_req->tc.sdata;
> +	req->length = usb9pfs->p9_tx_req->tc.size;
> +
> +	dev_dbg(&cdev->gadget->dev, "%s usb9pfs send --> %d/%d, zero: %d\n",
> +		usb9pfs->in_ep->name, req->actual, req->length, req->zero);
> +
> +	ret = usb_ep_queue(usb9pfs->in_ep, req, gfp_flags);
> +
> +	dev_dbg(&cdev->gadget->dev, "tx submit --> %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int usb9pfs_queue_rx(struct f_usb9pfs *usb9pfs, struct usb_request *req,
> +			    gfp_t gfp_flags)
> +{
> +	struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
> +	int ret = -ENOMEM;

Overwritten in literally the next statement.

> +	ret = usb_ep_queue(usb9pfs->out_ep, req, gfp_flags);
> +
> +	dev_dbg(&cdev->gadget->dev, "rx submit --> %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int usb9pfs_transmit(struct f_usb9pfs *usb9pfs)
> +{
> +	struct p9_req_t *p9_req = NULL;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	spin_lock_irqsave(&usb9pfs->lock, flags);
> +	if (usb9pfs->p9_tx_req) {
> +		spin_unlock_irqrestore(&usb9pfs->lock, flags);
> +		return -EBUSY;
> +	}
> +
> +	p9_req = list_first_entry_or_null(&usb9pfs->tx_req_list,
> +					  struct p9_req_t, req_list);
> +	if (!p9_req) {
> +		spin_unlock_irqrestore(&usb9pfs->lock, flags);
> +		return -ENOENT;
> +	}
> +
> +	list_del(&p9_req->req_list);

You have deleted it from the list

> +	usb9pfs->p9_tx_req = p9_req;
> +
> +	p9_req_get(usb9pfs->p9_tx_req);
> +
> +	ret = usb9pfs_queue_tx(usb9pfs, usb9pfs->in_req, GFP_ATOMIC);

This means that if this function returns an error, the deletion
from the list may or may not have happened.

> +	spin_unlock_irqrestore(&usb9pfs->lock, flags);
> +
> +	return ret;
> +}
> +
> +static void usb9pfs_tx_complete(struct usb_ep *ep, struct usb_request *req)
> +{
> +	struct f_usb9pfs *usb9pfs = ep->driver_data;
> +	struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
> +	int ret = 0;
> +
> +	if (req->status) {
> +		dev_err(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
> +			ep->name, req->status, req->actual, req->length);
> +		return;
> +	}
> +
> +	/* reset zero packages */
> +	req->zero = 0;
> +
> +	dev_dbg(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
> +		ep->name, req->status, req->actual, req->length);
> +
> +	WRITE_ONCE(usb9pfs->p9_tx_req->status, REQ_STATUS_SENT);
> +
> +	p9_req_put(usb9pfs->client, usb9pfs->p9_tx_req);
> +
> +	ret = usb9pfs_queue_rx(usb9pfs, usb9pfs->out_req, GFP_ATOMIC);
> +	if (ret)
> +		return;

Ehhh ? Could you explain the error handling here?

> +
> +	return;
> +}
> +
> +static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs, void *buf)
> +{
> +	struct p9_req_t *p9_rx_req;
> +	struct p9_fcall	rc;
> +	int ret;
> +
> +	/* start by reading header */
> +	rc.sdata = buf;
> +	rc.offset = 0;
> +	rc.capacity = P9_HDRSZ;
> +	rc.size = P9_HDRSZ;
> +
> +	p9_debug(P9_DEBUG_TRANS, "mux %p got %zu bytes\n", usb9pfs,
> +		 rc.capacity - rc.offset);
> +
> +	ret = p9_parse_header(&rc, &rc.size, NULL, NULL, 0);
> +	if (ret) {
> +		p9_debug(P9_DEBUG_ERROR,
> +			 "error parsing header: %d\n", ret);
> +		return NULL;
> +	}
> +
> +	p9_debug(P9_DEBUG_TRANS,
> +		 "mux %p pkt: size: %d bytes tag: %d\n",
> +		 usb9pfs, rc.size, rc.tag);
> +
> +	p9_rx_req = p9_tag_lookup(usb9pfs->client, rc.tag);
> +	if (!p9_rx_req || p9_rx_req->status != REQ_STATUS_SENT) {
> +		p9_debug(P9_DEBUG_ERROR, "Unexpected packet tag %d\n", rc.tag);
> +		return NULL;
> +	}
> +
> +	if (rc.size > p9_rx_req->rc.capacity) {
> +		p9_debug(P9_DEBUG_ERROR,
> +			 "requested packet size too big: %d for tag %d with capacity %zd\n",
> +			 rc.size, rc.tag, p9_rx_req->rc.capacity);
> +		p9_req_put(usb9pfs->client, p9_rx_req);
> +		return NULL;
> +	}
> +
> +	if (!p9_rx_req->rc.sdata) {
> +		p9_debug(P9_DEBUG_ERROR,
> +			 "No recv fcall for tag %d (req %p), disconnecting!\n",
> +			 rc.tag, p9_rx_req);
> +		p9_req_put(usb9pfs->client, p9_rx_req);
> +		return NULL;
> +	}
> +
> +	return p9_rx_req;
> +}
> +
> +static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
> +{
> +	struct f_usb9pfs *usb9pfs = ep->driver_data;
> +	struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
> +	struct p9_req_t *p9_rx_req;
> +	unsigned long flags;
> +
> +	if (req->status) {
> +		dev_err(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
> +			ep->name, req->status, req->actual, req->length);
> +		return;
> +	}
> +
> +	p9_rx_req = usb9pfs_rx_header(usb9pfs, req->buf);
> +	if (!p9_rx_req)
> +		return;
> +
> +	memcpy(p9_rx_req->rc.sdata, req->buf, req->actual);
> +
> +	p9_rx_req->rc.size = req->actual;
> +
> +	p9_client_cb(usb9pfs->client, p9_rx_req, REQ_STATUS_RCVD);
> +	p9_req_put(usb9pfs->client, p9_rx_req);
> +
> +	spin_lock_irqsave(&usb9pfs->lock, flags);
> +	usb9pfs->p9_tx_req = NULL;
> +
> +	spin_unlock_irqrestore(&usb9pfs->lock, flags);

Why can usb9pfs_tx_complete() touch this without taking the spinlock?

> +
> +	usb9pfs_transmit(usb9pfs);

This can fail. What happens then?

> +
> +	return;
> +}
> +


[..]

> +static int p9_usbg_cancel(struct p9_client *client, struct p9_req_t *req)

This ought to be boolean

> +{
> +	struct f_usb9pfs *usb9pfs = client->trans;
> +	unsigned long flags;
> +	int ret = 1;
> +
> +	p9_debug(P9_DEBUG_TRANS, "client %p req %p\n", client, req);
> +
> +	spin_lock_irqsave(&usb9pfs->lock, flags);
> +
> +	if (req->status == REQ_STATUS_UNSENT) {
> +		list_del(&req->req_list);
> +		WRITE_ONCE(req->status, REQ_STATUS_FLSHD);
> +		p9_req_put(client, req);
> +		ret = 0;
> +	}
> +	spin_unlock_irqrestore(&usb9pfs->lock, flags);
> +
> +	return ret;
> +}

	Regards
		Oliver

