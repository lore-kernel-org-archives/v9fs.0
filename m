Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB4A3D3D16
	for <v9fs@lists.linux.dev>; Fri,  3 Jul 2026 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091259; cv=none; b=HAZDmFt/hyIJgxczQ5fjP9QN70KQ7wIeAF6jaDdSBXB7xDWciKEWYY6fK4my41lwxF7NHMvAXm7+ycUPELB2oePwaa75gaSTpuX8O+EIJARqNC1BeC5UCzKphVpou1v+vOlW5hmv2LIuAdHNIHBHxF+TB7XCb/ORqs4sdydt0cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091259; c=relaxed/simple;
	bh=mgjyxZoiOvFijt/d+PC0DtD/Alk5U8ztsi8AqhLZuZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lT7QHwgOkmyk0M/R07dGaq08OOsCeYtoo+ydAHGNVCab+9684evufMAY/SUnbfh9AqA0f2Ovld6Q+TsLPmqiGvNHqfEAzjk1Rwp1yvXOxEHhnolj5TsaElHS8AoMcllMObFaecEg4nTVS4bqPvPRPQJBZHiVG2VaOGDktel8cWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P5vwjgPB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5vwjgPB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783091256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ufmoYIO+8FVkXj7I+/+r0HlaIjqkZ37cLPCzcjFGBsk=;
	b=P5vwjgPBojeX5Bsh5R7Pd6z8sQGAlxycRLohUM3RP0DkDauKWpiMZIcLKcDyS9fuUfhJhB
	LadJktNxFiE0U0uk9jpVqLAxveJcLGgI7qhZTAauNiNHTzupECaYTxk+d1o1uOuAcxwx/V
	CgrhFjKRJsQV2wBo3FTomXeLVxjkj0Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-x2tLzvlvNZGSyeOLpBrdOA-1; Fri, 03 Jul 2026 11:07:35 -0400
X-MC-Unique: x2tLzvlvNZGSyeOLpBrdOA-1
X-Mimecast-MFC-AGG-ID: x2tLzvlvNZGSyeOLpBrdOA_1783091254
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-492488f8583so9326825e9.2
        for <v9fs@lists.linux.dev>; Fri, 03 Jul 2026 08:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783091254; x=1783696054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ufmoYIO+8FVkXj7I+/+r0HlaIjqkZ37cLPCzcjFGBsk=;
        b=EBn8cCLTkDRkozA6x2oBNNAH+JF6XLKo8hhGGhrhm/jpr+KTG5hz03Eygkk3XyZZZ4
         k1+0MUr1nZ6fwPcp2nFINBz67/st9ek14qr2mJN6jECMZwOST9oMDXA+5JnmJI4wGERO
         V0xV7zzQdmJfEv1wzTtJdAOyMR5zZA/EvpXXflZgIqMs/lcwFPKMDMYTdv0+PrF2dWef
         qeU3jYOdamFqEJfIGFGqsUM0QJFGoHpnbWeJ4778Ww5wlMgbrWdSDBJZkvMsSf2DuJDB
         s20fs1HQe/jfswGevfus8NKqla9vLLDGCkqoeSjdPF9K6+/sj+chY9ZqO1tSEpUIZtfr
         kE3g==
X-Forwarded-Encrypted: i=1; AFNElJ9xAJp2a4jVX60A54FPBKXeHAiKrvqQMPLpOj1mdr7b9NqkCDL2cmtqzEZQ89U0jCYEsb5o@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4Ew5whNjZm+WCnhN3ZmNBdWwhYzW46gg+3yi0HkkNoWNCkdGy
	63QUpVeJu0vfcu49JqCjHTzBw6Lb20J0C1dgfs2wXy3RlmwJMbMdaATry+JiZgWGoB+/X3i75Ug
	D2p5eBxD6YzZfhL3+gOivtSoUoMYzh8fm1kp9EM8wvGPLS+gkDR+O3HU=
X-Gm-Gg: AfdE7cmWZwpQdwogMAYoEkz0mcCARbNrA8YHtynVp/qTg3eshipIUP9/GXSYQLehyrt
	ZPPHgip+rzYTjiXzVQpzzgNvSrxrOqkp0WJpO8gyngxHMs0X2jfYZzx+/rGVGrE1PKDTeOUridc
	fXFM5feb9gN2FsOQ6N6UdV55Ra9NxNTNeu/vzF0p5ZqmpFlJh5BnKlcumWPHM77WhjYNJ8aV7QL
	ueOeFA/R4Zgvyt5p/uKiNLdCsWjELj3GtP/d1dlNzPbowdFvORNfsCrxK7uGd5v/5I5crd/U+i/
	bCHKnTXMqvOQne+avrawL+9DwQjRQSYLJ+WWKYq4SIX0QySmT3abJORbJU02EpiLRDZ3vc6kb0q
	nJljRIwSwx8OjAO5ts1D7Ao8smLUhTPR3c3H6b4POzptyu8PTHqlj2X8uR2NKcSfw9p7tk718Sb
	XZyqA=
X-Received: by 2002:a05:600c:22da:b0:493:b55f:bca2 with SMTP id 5b1f17b1804b1-493d0f418famr2033635e9.34.1783091253955;
        Fri, 03 Jul 2026 08:07:33 -0700 (PDT)
X-Received: by 2002:a05:600c:22da:b0:493:b55f:bca2 with SMTP id 5b1f17b1804b1-493d0f418famr2033285e9.34.1783091253473;
        Fri, 03 Jul 2026 08:07:33 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ecaf:77c0:40ac:89a3:9858:a68e? ([2a01:e34:ecaf:77c0:40ac:89a3:9858:a68e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cfb6f199sm30527515e9.3.2026.07.03.08.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 08:07:32 -0700 (PDT)
Message-ID: <eb829084-0b8b-4317-a382-4a9d0a0b4bac@redhat.com>
Date: Fri, 3 Jul 2026 17:07:31 +0200
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 9p: fix privport option setting wrong RDMA field
To: Stefano Garzarella <sgarzare@redhat.com>, v9fs@lists.linux.dev
Cc: Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 linux-kernel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>,
 stable@vger.kernel.org
References: <20260703102254.114446-1-sgarzare@redhat.com>
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20260703102254.114446-1-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TYrHx7Aa7ZNPmRuqlHsVQPDnJyVruroTcJ0BKQesr84_1783091254
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/26 12:22 PM, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> While reviewing a patch adding vsock transport to 9p, I noticed that
> since commit 1f3e4142c0eb ("9p: convert to the new mount API"), the
> Opt_privport case incorrectly sets rdma_opts->port instead of
> rdma_opts->privport, so mounting with the privport option overwrites
> the RDMA port number instead of enabling privileged port usage.
> 
> Fixes: 1f3e4142c0eb ("9p: convert to the new mount API")
> Cc: stable@vger.kernel.org
> Cc: sandeen@redhat.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Ugh, sorry about that.

Acked-by: Eric Sandeen <sandeen@redhat.com>

> ---
>  fs/9p/v9fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> index 274c5157135d..f426cee37414 100644
> --- a/fs/9p/v9fs.c
> +++ b/fs/9p/v9fs.c
> @@ -406,7 +406,7 @@ int v9fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  		break;
>  	case Opt_privport:
>  		fd_opts->privport = true;
> -		rdma_opts->port = true;
> +		rdma_opts->privport = true;
>  		break;
>  	}
>  

