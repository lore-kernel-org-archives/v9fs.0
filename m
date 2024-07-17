Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6571F1849C2
	for <v9fs@lists.linux.dev>; Wed, 17 Jul 2024 21:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721252574; cv=none; b=lmwBHLMKWSxs/1VsesCuM1xL/st9XT0yhb3a62lS+C1CpaXZm9QzjwUoxcuGt4Hw2CUK+YLfAdXUErUS7AEKHO6F0qzmSnBNRoV0rBMNMhZDHdJBDn5l7PocChv3ybl+V88psIfW85V3v6FugnxRr3EhImd8M3SKOWUIsRyv4x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721252574; c=relaxed/simple;
	bh=bsWSpWbACmHKusEK41PKTWLYbuBJxwdBeyt+4p90FyA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5JT3sOfDRDZ39sqdFoTIUH6dST9aDdjjNhlp90QUxBtbUl7UnD0iW6b81lFdOhpH5N4dg2q8iRd6YWIptkYFFDjmnYdASDNUqdqpq+L0bH9w8xyFbmzOwasJlbbBhRvuUjcjGnP0WT68FCo0dwkrWF7IbzrWS+3tFx7t5PTCmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGROl6SF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGROl6SF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9892C4AF0B;
	Wed, 17 Jul 2024 21:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721252573;
	bh=bsWSpWbACmHKusEK41PKTWLYbuBJxwdBeyt+4p90FyA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NGROl6SFZXgDM3saA9vf9IhdXsLUU8rpKfgcLjQGlsnE5P0RJmKzHTd/lKwJ1kGGd
	 Hc3irdwz+OZj1Wx9OSm4qMpsP1F6LW0qg7j9b/rDgqqlPl3zysDKWV/cvYNtGcS91W
	 mrHripnnWQvnnMLjLIboXGvANMaCmcF48uuCs2BeE+kAjH0V3XBasVa8lFhIeAnuhW
	 YO9NdYeusR1ukSqQzahFWdw4c3A8ZURnQcayuTxghv4gml/sMn9aVnx5V9wgWA0ZF0
	 YZUFhr1/GZG8N0/DjXYDCvLL1GIMUTPdyu5ht0SQd83hQboliw+smgGnIsjWw236Vf
	 EC+tiBoLfIoeg==
Date: Wed, 17 Jul 2024 14:42:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet
 <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>,
 v9fs@lists.linux.dev
Subject: Re: hangs after merge window changes
Message-ID: <20240717144221.0c5afd01@kernel.org>
In-Reply-To: <CAFkjPTnktf6puYAyg4pNh8RtQvSuQnSo5VCQvinv=Cw9m1s9xQ@mail.gmail.com>
References: <20240717102458.649b60be@kernel.org>
	<CAFkjPTnktf6puYAyg4pNh8RtQvSuQnSo5VCQvinv=Cw9m1s9xQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jul 2024 13:01:26 -0500 Eric Van Hensbergen wrote:
> I held way back on adding anything new over the past cycle, so this
> sounds likely some external change maybe perturbing an older issue.

Ah :(

> What guest side mount options, qemu options and qemu version are you
> using?

I use virtme-ng, according to ps qemu gets called with:

/usr/local/bin/qemu-system-x86_64 -name virtme-ng -m 1G -fsdev local,id=virtfs5,path=/,security_model=none,readonly=on,multidevs=remap -device virtio-9p-pci,fsdev=virtfs5,mount_tag=/dev/root -machine accel=kvm:tcg -device i6300esb,id=watchdog0 -cpu host -parallel none -net none -echr 1 -chardev file,path=/proc/self/fd/2,id=dmesg -device virtio-serial-pci -device virtconsole,chardev=dmesg -chardev stdio,id=console,signal=off,mux=on 

-serial chardev:console -mon chardev=console -vga none -display none -smp 4 -kernel ./arch/x86/boot/bzImage -append virtme_hostname=virtme-ng nr_open=1073741816 virtme_link_mods=/home/virtme/testing-1/.virtme_mods/lib/modules/0.0.0 virtme_rw_overlay0=/etc virtme_rw_overlay1=/lib virtme_rw_overlay2=/home virtme_rw_overlay3=/opt virtme_rw_overlay4=/srv virtme_rw_overlay5=/usr virtme_rw_overlay6=/var virtme_rw_overlay7=/tmp console=hvc0 earlyprintk=serial,ttyS0,115200 virtme_console=ttyS0 psmouse.proto=exps virtme_chdir=home/virtme/testing-1 rootfstype=9p rootflags=version=9p2000.L,trans=virtio,access=any raid=noautodetect ro init=/home/virtme/virtme-ng/virtme/guest/virtme-init

QEMU version is 8.2.1 (built from source)

> Dominique, you aware of anything coming in that might have messed with
> this?  Maybe the new common code refactoring underpinning
> readahead/etc.?
