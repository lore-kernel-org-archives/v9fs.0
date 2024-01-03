Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D2B1DA47
	for <v9fs@lists.linux.dev>; Wed,  3 Jan 2024 22:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1zkuLrM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728D2C433C7
	for <v9fs@lists.linux.dev>; Wed,  3 Jan 2024 22:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704322105;
	bh=AoabcyB4YoKIa/g8B49r+xZZ1TYQ03EoECDmS8rGu3o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z1zkuLrMOm+4LmYF2naqJ+3ykSFBkvJfgAb//KnT/2EnaW4elaPTmCIBzc/s4VXf0
	 S3Ocabs3zIZ1w2gqRrX50ZMNQizkNnd1H9jPObLNsxvsqBQXNWyRI2neatdJvYbL+o
	 Eq4lQcbNDCYQLZkHFGocy7FEyvi4xVUrlLtRwKv5NNYKDg3RYZz7dqxC8k6r+cgG5T
	 8BB9tAcY6uxo+YoCiUVza3havmavNGO2S2niaJgcrcd71t6LfWyfnkd0d7iLQ/pXax
	 azMr2LuM3SzsIpwBxpmVv1nTraptzAhRHRNrw0lDrnh5rCJpHSHTgHG1JyGOp0T/HC
	 mmVN1GsvCAq3A==
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso5512660276.2
        for <v9fs@lists.linux.dev>; Wed, 03 Jan 2024 14:48:25 -0800 (PST)
X-Gm-Message-State: AOJu0YwxnxKWYmIX6nivwrThMZfhtxqDBviIePBQEMQNsxD61TIW1Wwt
	pN6E0i93gqlGQJDzlf+Yzs8MSLLz/FVb9+uaHZc=
X-Google-Smtp-Source: AGHT+IGKFJkU02EtWAYwIHgSIUnoprr6jxR6ywoPfUfJtGRx2PWTIMRBmud3Qz5hqEuE2wjtT74WTKdwW3VggDbX4xQ=
X-Received: by 2002:a25:d747:0:b0:dbd:a113:cc16 with SMTP id
 o68-20020a25d747000000b00dbda113cc16mr7089195ybg.129.1704322104793; Wed, 03
 Jan 2024 14:48:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZZWi6fbgy8oGwR1D@FV7GG9FTHL> <ZY7qr1Dy_aS716dC@FV7GG9FTHL> <ZZXCiSlrAMI5sMr3@codewreck.org>
In-Reply-To: <ZZXCiSlrAMI5sMr3@codewreck.org>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Wed, 3 Jan 2024 16:48:13 -0600
X-Gmail-Original-Message-ID: <CAFkjPTnCoQXMaRXhFuzquZaKe7DFfzEEGi_Z8f7hA6Rn0wHtYA@mail.gmail.com>
Message-ID: <CAFkjPTnCoQXMaRXhFuzquZaKe7DFfzEEGi_Z8f7hA6Rn0wHtYA@mail.gmail.com>
Subject: Re: cache fixes (redux)
To: asmadeus@codewreck.org
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

One other thing I noticed when looking through the code (related to
xattrs and acls) - it seems on create we are pre-populating client
side ACLs -- this requires some extra protocol and steps it feels like
we don't have to take.  So I guess two thoughts:
- shouldn't the server side be populating ACLs appropriately on create
if the underlying file system supports them
- if this isn't the case it feels like we might be able to get away
with a slightly reduced approach of walking to the new fid and sending
the appropriate setacl proto messages and then rely on the inode
refresh to fill the cache (if the cache is enabled

A bunch of this has come up unwinding complexity in where we are
"creating inodes" versus using iget with optional create.  I think
everything needs to use the latter so things show up in the hash
appropriately.

     -eric
