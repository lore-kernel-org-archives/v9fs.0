Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A08320FA81
	for <v9fs@lists.linux.dev>; Thu,  7 Nov 2024 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987822; cv=none; b=hytSPnTy4pSHYCXpJtapgoOxKoZs3J7318MPN8WfS7QTPX+eLSRJm8IJpPmGuq4NEv+5WdT2g6xgWM7SfavXSm2ukg1/ExGHoJrFINbr+46FHxEAgDFCMBx5+e13OA3IjV0yjM8I+pqhLdEwI+5/IgQAIg6VImPijhCX76TUFO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987822; c=relaxed/simple;
	bh=qnMMY1EBIMFNCCj4m0hlU1mf5a1ROCT94LHu26I+oyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuFdv/etU5eqbX72r6D6VIo/qbfFV4zFitZlzLfQbRcc+6K08UDx9bGm5x/OzTvuZnqS70psqIMi10pE5rtRWGmwPtUZ7kiWsqf6iRu089dhufTrzQitFZhQtEvSk+79cHEB5Kd6OdM/9coRbnrDu9hSkc+3Qm3+ff9ff12FHBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NxWR3enA; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NxWR3enA"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c9693dc739so1399277a12.3
        for <v9fs@lists.linux.dev>; Thu, 07 Nov 2024 05:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730987817; x=1731592617; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B4NpyOY6rUFjw/BWN7djSiT97ykyDTjSO50iSeMBEZ0=;
        b=NxWR3enAPJbkesvzHNSIpYpoDbzHqGq2MqIn2TDLBMcIx+60GX7gmXJ6EeBf6kOhk9
         qWi0mcWuNwoIHhNGBfUrEzKL5WTXaioDFGI9/0hI+7oBrzfj/BG/jH5i3mlLbOgAhSjK
         wINrn+049wxWggVxeVtw+gAKIQZCR62WRhuhtThlxVSFY+dK73CMlmwW5zS+T/As58XM
         idAi+L5qL254YSw7PzdHnuKTjKkZw6dVDmTChm+6F6n2bRlqf1H3gxC8wNDT3l/kuk6e
         66+DPcoRJO+ED5+qJpAI77zTSWuE7ktilr1ufqao1a4fPQTY5cWzDx3jTC5V+YQR+zTX
         h4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730987817; x=1731592617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4NpyOY6rUFjw/BWN7djSiT97ykyDTjSO50iSeMBEZ0=;
        b=UwbspvKOwd8rTXg/19s8EKzj3JMWSJmJEejJqx1oLTULB0YT+6Eh+CB4DFUKi5u4NG
         TVYdRYispLHVdH72Fh8UhRXrHgbDuA+NhWrFJRiOLSmZz1gvNUTzdRm8F4d1AmNlVYEl
         uf8rwrZcWRec49QlylOFKtnvnktWiX2TYjDK+IYeJKlH/hc4gWI6Zua3lVNp7AHGOaYW
         F+TOj7PrvuSSZGWsBKIMxbi0s9J4i1v/Wgn+XEXy3ZiJmCodI/uZ9ij5QNd49Gq1Ys+r
         J4pGZm+9KMwjdWecf5Ob8fe5IlxB1/Mz3RwpT4flmAF9hm6lLYtCkl4mHcknFvTR0aSG
         j31w==
X-Forwarded-Encrypted: i=1; AJvYcCVJcZLB3MU443icb5C2gKcknQrS+XocWu0IAKV3amrjVV7870vXf5ILDeiX8734omUAx8W9@lists.linux.dev
X-Gm-Message-State: AOJu0YzzXE4CRTOD+mPeE8wsKa5kY4c9iQfclJ3pn+rm4nGsovhRMKxa
	Wo9uEECwJslspHJMFYzyw/jsR4gYjpCltGUNxsDxGhhZeb5f7h3/30ex9vMODbk=
X-Google-Smtp-Source: AGHT+IGH/e4k1MIhd1tMRWeuprRyYe0nFe/9dywi2+snJ2+871SY5AWuiZ+eYzeGjIiiWkZbc4wxiQ==
X-Received: by 2002:a05:6402:d0e:b0:5c9:76f3:7d46 with SMTP id 4fb4d7f45d1cf-5ceb928c9damr15946992a12.21.1730987817587;
        Thu, 07 Nov 2024 05:56:57 -0800 (PST)
Received: from localhost ([89.101.134.25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4ed9fsm814147a12.62.2024.11.07.05.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:56:56 -0800 (PST)
Date: Thu, 7 Nov 2024 16:56:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2][next] fs/9p: replace functions
 v9fs_cache_{register|unregister} with direct calls
Message-ID: <d410dce3-36ce-4663-94ca-25bad2f91ad4@suswa.mountain>
References: <20241107095756.10261-1-colin.i.king@gmail.com>
 <Zyyt0XUv0Ypl56qI@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zyyt0XUv0Ypl56qI@codewreck.org>

On Thu, Nov 07, 2024 at 09:08:49PM +0900, Dominique Martinet wrote:
> Colin Ian King wrote on Thu, Nov 07, 2024 at 09:57:56AM +0000:
> > The helper functions v9fs_cache_register and v9fs_cache_unregister are
> > trivial helper functions that don't offer any extra functionality and
> > are unncessary. Replace them with direct calls to v9fs_init_inode_cache
> > and v9fs_destroy_inode_cache respectively to simplify the code.
> > 
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> Thanks!
> 
> Acked-by: Dominique Martinet <asmadeus@codewreck.org>
> 
> 
> @Dan, I don't have anything queued up 9p-wise so if you want to take it
> through the janitor tree it'll probably get in faster; otherwise (if
> you'd rather I take it or no reply in a while) I'll pick it up when
> other patches come in.

There isn't a janitor tree or any rush on this.  ;)

regards,
dan carpenter

