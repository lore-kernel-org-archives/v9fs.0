Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579A77B
	for <v9fs@lists.linux.dev>; Tue, 25 Apr 2023 13:15:04 +0000 (UTC)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-440403d34a4so2070343e0c.0
        for <v9fs@lists.linux.dev>; Tue, 25 Apr 2023 06:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682428503; x=1685020503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wqv8r/KFOBnoNWbUFUiDZTpYWxmph2Y+u4MhHtRun0M=;
        b=ctzWSSvCj4vVhD0Ybx0qlOxNqi9C5x7m7v/8XFMMh9Es8CtzsbZ1zqBQi3LBduNHZg
         sUusmouGhQJLLIcVoQYK27s1UZWgfu+K7Jrrdn3K6qFA1hIb1vtlpus2ZjCKSzW+r8Nn
         +pjxutdbxj6cZFtWfE6ILgKqpOUIh0banzxMPqR72qQ1bGSFJ7/0nnATmOA4kwzBMODQ
         FfPHoVA+jAHaK+TgCZJuLKhxw2C1hlV95n525LxdKY+QC/8EVs42fURaJ6GTK30/Q4Qy
         y4Pg2DTxOR+BnufXAPk+AD/WcPPcpkqmZWAvdqcrCG+ZfaNM49pIO4UEwKtlLyNYGaz+
         XnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682428503; x=1685020503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wqv8r/KFOBnoNWbUFUiDZTpYWxmph2Y+u4MhHtRun0M=;
        b=HaBIOAhAwzLg8jkh+iRWWhWDhTQi+zT7y9U5kF0wTOdgJUU228TkM8Pj6AGylJQvhA
         RYZ/A1U2Zhj3JMRVsg9DHtI7fFg4AOb8/KFQA04yLsS3jcWnyr5xPHF4xaGRYKwq+GnV
         jNi5mibF2ffFzJ9JE5TEmtV8n4j0Wm0TlxrWLm+9FB5k0MiMfjtauR4rhWI61bDHxDXS
         9q03tGbDNoVH00q3gq8gOaiTuRIPmeEJi0Z42w8B2vLu/tbt2HshkTnZFroEclVgXt4O
         j33hZENlF9aH67iuNM4oGl7YUpqgXa2ayJ5BBwq7rplDvWAyDLfnquAIL5LBKujsFID7
         mkhQ==
X-Gm-Message-State: AAQBX9feFN3bE8Ypplb7bUsrujYymHwloTyPS3wqD53Oftm3Skwt5939
	yXqPrF1yDMtTCBdqsTY8mraKHMcpuDTRLB9tEh0=
X-Google-Smtp-Source: AKy350aanME0nMTNiM5fr4DFHHkaaB3EACxyhrJA3uB0MY8jl99vfng8dUxqcDxlYYiue3Q6E7DZYBnfyNJxlG5eh68=
X-Received: by 2002:a1f:c506:0:b0:43f:9aa5:a15b with SMTP id
 v6-20020a1fc506000000b0043f9aa5a15bmr4311156vkf.9.1682428503125; Tue, 25 Apr
 2023 06:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <80bae984fd5ca49b691bb35f2fd8f345f8bb67f1.1682405206.git.christophe.jaillet@wanadoo.fr>
 <ZEd8d7W6HnHE_66m@codewreck.org>
In-Reply-To: <ZEd8d7W6HnHE_66m@codewreck.org>
From: Dan Carpenter <error27@gmail.com>
Date: Tue, 25 Apr 2023 14:14:52 +0100
Message-ID: <CA+_b7DK1s87y-_-D3sQxteqJ+78uvKza-vgWGv9SmGm-tqz7DA@mail.gmail.com>
Subject: Re: [PATCH] fs/9p: Fix a datatype used with V9FS_DIRECT_IO
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 25, 2023 at 8:12=E2=80=AFAM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Christophe JAILLET wrote on Tue, Apr 25, 2023 at 08:47:27AM +0200:
> > Fixes: 6deffc8924b5 ("fs/9p: Add new mount modes")
>
> (Not a problem per se: but note this commit hasn't been merged yet, so
> using commit IDs is a bit dangerous. Might want to remark this in the
> free comment section so Eric pays attention to not break that when applyi=
ng)

This is fine.

The hash is constant unless Eric does a rebase.  When a maintainer rebases
then updating the fixes tags is just part of the process.  Often they end u=
p
folding the fix into the original patch at that point so the Fixes tag is n=
ot
required.  If a maintainer doesn't update the tags then the linux-next
maintainers
will notice and complain.

#GitMagic

regards,
dan carpenter
