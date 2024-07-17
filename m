Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B3F18EBF
	for <v9fs@lists.linux.dev>; Wed, 17 Jul 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721259053; cv=none; b=ei8OGxW5TMN5fGp7+zfxUUsl7euqRuyT+NQ4hy+JxUz8ScdoVytD3T42P947fn8u8JswSAzNLRdc5i6LvAmFyTYNup8uS0TZ/vtiyzwiXU+1LFF0iKc6/swqj0npt4StvSh2vBQX6pGZjGAonTaTpivaJNIzmUFNnssQ9TqnOSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721259053; c=relaxed/simple;
	bh=+zKMy1VTWyxmmziCnrHhdmD+UQ0UqOz72iTeM+Cz60Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHyUkjnkT6ToIbToCy5EB1hlgQZ3Etj+e0XT4zE4HeS+1R/dxXemRxGRT5OtELoh2X/GzX7cuT7a2WmisNcXaPXSOKiOtT58Tjxzlk0VZAOTdbuDqn60DEFMobyvcrn4LEUedXzEv3S2HK6nW7pKRhv9mDBh7027u/Qj77tgihk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ov/00k3J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ov/00k3J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F1FC4AF0B;
	Wed, 17 Jul 2024 23:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721259052;
	bh=+zKMy1VTWyxmmziCnrHhdmD+UQ0UqOz72iTeM+Cz60Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ov/00k3JPVjq9UdIMU7/uZf3/4RBtvz4XzmVQHVPapdi7GU9uOoKfs9WgEyWdREGs
	 ig/6+UvwxIFIR3dT8S+1dCLsb2kevNJ49UjM5TyFVBJcT8n5dAFF/ZUaQW2RlSDt1T
	 R9jbd51KQbDHxvG2286l+qUQxNajmt35v6c6r5S+sD7isHyxKnvImrjCcSfL65UUPB
	 SQb0e5tYpGc3HH9aor/retih2OQ+mWGkNRBVEl/myqTKB8fusMgNm0APEZ86cZhrWn
	 Sw7hTeTAYQ/XKIsBWfOeGWF5+te8TEYsB4O1NVKcvn/283Zm2EaHQrxPmmEv0WJvEE
	 /O372KMK4q1HQ==
Date: Wed, 17 Jul 2024 16:30:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>,
 v9fs@lists.linux.dev
Subject: Re: hangs after merge window changes
Message-ID: <20240717163051.13e41526@kernel.org>
In-Reply-To: <ZpgtXjz3pbJKUjL7@codewreck.org>
References: <20240717102458.649b60be@kernel.org>
	<CAFkjPTnktf6puYAyg4pNh8RtQvSuQnSo5VCQvinv=Cw9m1s9xQ@mail.gmail.com>
	<ZpgtXjz3pbJKUjL7@codewreck.org>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Jul 2024 05:45:18 +0900 Dominique Martinet wrote:
> Eric Van Hensbergen wrote on Wed, Jul 17, 2024 at 01:01:26PM -0500:
> > I held way back on adding anything new over the past cycle, so this
> > sounds likely some external change maybe perturbing an older issue.
> > What guest side mount options, qemu options and qemu version are you
> > using? =20
>=20
> Mount option if any would be much appreciated, yes.
> Also, what version you upgraded from to limit the limit the search a
> bit; the previous 6.9 tree?

Between networking pull requests. Basically
528dd46d0fc35c0176257a13a27d41e44fcc6cb3 to=20
51835949dda3783d4639cfa74ce13a3c9829de00

> Also couldn't find much infos about the CI in general, given the traces
> I don't think the workload matters all that much but it can give
> something to start with e.g. running from initrd and mounting 9p or
> using 9p as rootfs; that shouldn't make a difference but might as well
> try to reproduce from something close to the actual netdev CI given the
> low reproducibility.

What CI does is described here:
https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-st=
yle
it's fairly simple, virtme-ng just runs kselftests inside a VM with=20
the host FS mounted via 9p-virtio.

I'd offer running experiments on the exact systems, but this week=20
I'm partially AFK (at a conference).

> > Dominique, you aware of anything coming in that might have messed with
> > this?  Maybe the new common code refactoring underpinning
> > readahead/etc.? =20
>=20
> Given the trace it's probably stuck in __wait_on_freeing_inode (the only
> schedule() call in find_inode_fast), so we could be looking at
> fallbacks from the iget changes but that made it in 6.9 already so
> that's unlikely...
>=20
> I have a feeling that adding cache will make the error go away if you
> just want to fix tests for now, so would be great if you could try
> adding -o cache=3Dloose to the 9p mount options; hopefully the inodes
> won't be freed as often and that'll make the race harder to hit.

Poked that into where I think virtme-ng does the mounting, let's see.

> I had a quick look at other globals fs changes and nothing stood out,
> it's going to be fun to track down.
>=20
> > On Wed, Jul 17, 2024 at 12:24=E2=80=AFPM Jakub Kicinski <kuba@kernel.or=
g> wrote: =20
> > > Apologies for possible duplicate, I tried to search lore and haven't
> > > found anything, but also I can't find the exact 9p archive there :S =
=20
>=20
> The new list is here: https://lore.kernel.org/v9fs/
> You probably didn't miss anything :)
>=20

