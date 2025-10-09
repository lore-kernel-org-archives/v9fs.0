Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADCA26F462;
	Thu,  9 Oct 2025 20:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760042712; cv=none; b=qlL1vM68AiftpNc/boTB9UN4tr7jDoMZuR/92XDTPd2AJ2uLZcXbinXKAb5VcN0ARJiVc/NNDpulbK1tLDcaACEe2LgpYBVh9TKZJ1dXApiiAGVWleKxhdiBCp+CTOxreVyWjfShxkXIQXeWsPyJs7Y5QU/ZA4nczudshJXPuNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760042712; c=relaxed/simple;
	bh=236wtHdAI2bp5NHN+UNZXc8SYgVOsEIzVZOqSRuxX7M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=N/KMisf7vGFj8WUowtTbY7bZB2khzVuXliX4eHiStd1WNjlWpAl1AZzUlWyFmg2olFBNqv0EXt0rKLwKolxr6RmxjAuH4lpg6YShJUiCssfHuoLUq3NYh/3zS9aX7RWjq9oU3SfTDqgwt+fnDoxmpyjNQFSkMvzzUIFVBNyMa1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kj6vrw1B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kj6vrw1B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFB2C4CEE7;
	Thu,  9 Oct 2025 20:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760042711;
	bh=236wtHdAI2bp5NHN+UNZXc8SYgVOsEIzVZOqSRuxX7M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Kj6vrw1BymYrcS3qH3C8CUf/068OWYQVCsJrwPLKKVXVJxbbSqIBzFpEeZ+sopzcN
	 rLOTTTsOz/aVWpsozPZ/QhN4z/WKHM0BPxJaFVCqPHm2L7CULteJRyUW9m410BYJ1D
	 b027C6Wo6pNeaq5pqndqfKSU3PVfL8bXtemQlocAmTj+iew5tshPzeL1kVzp1EUzpo
	 Ju478OHwz+gdp4KqV+e4OwhOoqeAf/y4LVcSDXteO85hrg5Xm808d3Vokn26mt1K29
	 kBKfvNy7X6q/WoHIYP6bGTDSPXPWargbvRlCzIfB2x8gMmkyfRe5uOtKrZWLikWWXq
	 zb5fh4Uu/IqhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB05F3A55FA1;
	Thu,  9 Oct 2025 20:45:00 +0000 (UTC)
Subject: Re: [GIT PULL] 9p fixes for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aOe0P8ixMEg4ul5K@codewreck.org>
References: <aOe0P8ixMEg4ul5K@codewreck.org>
X-PR-Tracked-List-Id: <v9fs.lists.linux.dev>
X-PR-Tracked-Message-Id: <aOe0P8ixMEg4ul5K@codewreck.org>
X-PR-Tracked-Remote: https://github.com/martinetd/linux tags/9p-for-6.18-rc1
X-PR-Tracked-Commit-Id: 528f218b31aac4bbfc58914d43766a22ab545d48
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80b7065ec19485943fa00d60f27b447c3f17069c
Message-Id: <176004269956.271849.831008222141267581.pr-tracker-bot@kernel.org>
Date: Thu, 09 Oct 2025 20:44:59 +0000
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>

The pull request you sent on Thu, 9 Oct 2025 22:10:23 +0900:

> https://github.com/martinetd/linux tags/9p-for-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80b7065ec19485943fa00d60f27b447c3f17069c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
