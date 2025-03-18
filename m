Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5992F202C5C;
	Tue, 18 Mar 2025 21:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742334195; cv=none; b=Xv6tDWhYz/DTO7ZU5XOe7NC1YE3NsNwEbfbWN1zwjnJg7LJSpXYPKtd9fwNjg9U7fZvvQdwl3dMwXAHA3XNMtvv0FBBAtHj6zr4l4BAwquNhgNO3alZjRdmGqTnzocI4tu+B/0fLUTOyJtgi4Su5PR9vydFxddrdcIO/L7mznUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742334195; c=relaxed/simple;
	bh=4dED7hVpq6gqnyJY9EEsncwP5zvCmbRoN0mpyCdZkYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCO5yvlQvmzuLjY16YofY51lygZPJ5alO1b7Jvq573mG7CuMb/GWz70pV3KnNTfA0liywRzg7m0GeZujN4yjcPJYequamlFmsk8B4B1bSS/di1FU6qYLaK/3qI6kIdpuPIX3Gi6OJtj7vWVaQAKroa16gqZBNdS9olYTlRtl5dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=zBrOpuDq; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="zBrOpuDq"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 1E04714C2D3;
	Tue, 18 Mar 2025 22:43:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1742334191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LTUYU9liPUrdPI70A5WeQvjUdz06iAyhiJ219fE6h24=;
	b=zBrOpuDqTavkvjhQyTFaBgB+74ujwo6psdMCJb5JSuuNFEgDJ+6JsUjuyBKu4OlBihbiSH
	6ZNtNJiMeewh00IbwXcrXvssRhoffbf9qO/nJLdHwzYkE32/wApnLwp711zyRlZ09ERtCP
	Yk7x/N+bngTjRG+XB5rcFCnpnJt4e3byiNEtlyaqvcitenl229PfTYCI2iFvs0my49AcRe
	KfwFycZvQt9pBRlCVnCQ2Ix3SNLMkqi3U1ZxdZIOBsK7JZE2i+jo1sVF2zp71HbcOpBHsQ
	Iq8tcBYtVHyVry25smDZHEUj14Ijm6l1MEvcs06Tkucljak8VVNOVq8dViu/nQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 6693bcdb;
	Tue, 18 Mar 2025 21:43:08 +0000 (UTC)
Date: Wed, 19 Mar 2025 06:42:53 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Ignacio Encinas Rubio <ignacio@iencinas.com>
Cc: Ignacio Encinas Rubio <ignacio.encinas@semidynamics.com>,
	linux-kernel-mentees@lists.linux.dev, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v2] 9p/trans_fd: mark concurrent read and writes to
 p9_conn->err
Message-ID: <Z9no3dnDt2mkd2MJ@codewreck.org>
References: <20250313-p9_conn_err_benign_data_race-v2-1-0bb9f45f6bb2@iencinas.com>
 <Z9dBfEf0naCsNrNv@codewreck.org>
 <0807e0cc-457b-49bd-bce5-a961ad7f0ffb@semidynamics.com>
 <fd13d2e0-1ed2-4b63-ab3a-4cb650b45a2c@iencinas.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fd13d2e0-1ed2-4b63-ab3a-4cb650b45a2c@iencinas.com>

Ignacio Encinas Rubio wrote on Tue, Mar 18, 2025 at 10:21:52PM +0100:
> Trimming CC to avoid spamming people (I hope that's ok)

Probably fine :)

> > This is weird... I'll double check because it shouldn't generate the
> > same code as far as I know.
> 
> I had a bit of time to check this. I understood you said that (A)
> 
> 	err = READ_ONCE(m->err);
> 	if (err < 0) {
> 		spin_unlock(&m->req_lock);
> 		return READ_ONCE(m->err);
> 	}
> 
> compiles to the same thing as (B)
> 
> 	err = READ_ONCE(m->err);
> 	if (err < 0) {
> 		spin_unlock(&m->req_lock);
> 		return err;
> 	}
> 
> if you didn't say this, just ignore this email :).

Right, I checked by looking at `objdump -D` output after rebuilding the
.o.
I've just double-checked and these two are identical:
```
err = READ_ONCE(m->err);
if (err < 0) {
    spin_unlock(&m->req_lock);
    return m->err;
}
```
```
err = READ_ONCE(m->err);
if (err < 0) {
    spin_unlock(&m->req_lock);
    return READ_ONCE(m->err);
}
```
but now I'm double-checking returning the local variable
```
```
err = READ_ONCE(m->err);
if (err < 0) {
    spin_unlock(&m->req_lock);
    return err;
}
```
is properly different (and is the right thing to do), so I must have
checked the wrong .o, sorry for the confusion.
(that or the minor gcc upgrade I did this morning change this, but I'd
rather inclined to think I screwed up...)

> With gcc (GCC) 14.2.1 20250110 (Red Hat 14.2.1-7) I'm seeing a difference:
> (A) performs another memory read after the spinlock has been unlocked
> while (B) reuses the value from the register. If you're using an old GCC
> it might have bugs. I can't recall where exactly but I have seen links
> to GCC bugs regarding this issues somewhere (LWN posts or kernel docs?)

Right, I'm seeing one less mov as well

So, yeah, v3 with this would be great :)
I don't have a strong opinion on the READ_ONCE within the lock, so if
you think it's clearer without it then I'm fine with that.

Thanks for taking the time to check!
-- 
Dominique Martinet | Asmadeus
