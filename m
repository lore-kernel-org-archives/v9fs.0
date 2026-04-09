Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730462B2D7;
	Thu,  9 Apr 2026 01:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775698246; cv=none; b=erTcx4IehBDe00wbwnFywhS2gpGLET9PZvN0YTKlVPXHo8HQ4YyDhHxVocpMfUnkLjm9PknyJPFUHqhJuVrAzQbbpnnH7JwT9J9Tm6b8a3gXfGGfzX0TKoz22OqG0iOlLkFvroLZ7c9KJ4PNg0kdSGGfzw0LSgzanmX9ifWNylE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775698246; c=relaxed/simple;
	bh=FBEyQ9IbTg/LWKbs1uz/1I3Bs7AvJSna04LKBfN/Sl4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FqKOkTGQOMsE8A/6cmszUytFouBbvqAPAHYU7npCMbq6wW9tTbGEDuqSYfQBhB0r29+J8fURLDFaNURPeoaI9aNSd07VVlQoYuJeY1YflaATT5ETAMDckM0i2anmmJRImDvbf0kYrkmc95uLNZspnN9l7S4/jeOdGrs4lILlM38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3p9mPJ/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3p9mPJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BC4C19421;
	Thu,  9 Apr 2026 01:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775698246;
	bh=FBEyQ9IbTg/LWKbs1uz/1I3Bs7AvJSna04LKBfN/Sl4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=C3p9mPJ/YP30Q84YOtPNpFrQSBtXxlsd/OZWd4W2pQaV0pcQHjs9UXru2SghX8LCf
	 tcjK5JEVPfl9BPJobZZkQRAfuNpCFIWSwO1cBHlFQS/yyYxhdNJBjopMtejR1lhf01
	 EeWfXbEbbQIAdUVyadT3s7/X/J61DOIwnkVpX/TtQTFb5IF1G/SyAbI7hI9yFECXAD
	 e6Ll6y4f2WjjVc11Lh/4a41Cfu7UBUb/j2FboiRSOJ+wfBhT1mUPNJmHhkluR558io
	 59WEEjGOPaZAM7j6eaHu2EcDcnbul79sg9RrnnT7VfJTZyc1j7UfQCwbe8HZYe+p6u
	 2oJjt/hptL9sw==
Date: Wed, 8 Apr 2026 18:30:43 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Eric-Terminal <ericterminal@gmail.com>
cc: asmadeus@codewreck.org, ericvh@kernel.org, lucho@ionkov.net, 
    stefano.stabellini@amd.com, v9fs@lists.linux.dev, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] 9p/trans_xen: replace simple_strto* with
 kstrtouint
In-Reply-To: <20260324153023.86853-3-ericterminal@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2604081830330.2873990@ubuntu-linux-20-04-desktop>
References: <20260324153023.86853-1-ericterminal@gmail.com> <20260324153023.86853-3-ericterminal@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 24 Mar 2026, Eric-Terminal wrote:
> From: Yufan Chen <ericterminal@gmail.com>
> 
> In xen_9pfs_front_init(), parse the backend version list as comma-separated
> tokens with kstrtouint(), keep strict token validation, and explicitly
> require protocol version 1 to be present.
> 
> This replaces the deprecated simple_strtoul(), improves error reporting
> consistency, and avoids partially parsed values in control paths.
> 
> Signed-off-by: Yufan Chen <ericterminal@gmail.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

