Received: from a27-188.smtp-out.us-west-2.amazonses.com (a27-188.smtp-out.us-west-2.amazonses.com [54.240.27.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79AE79DE
	for <v9fs@lists.linux.dev>; Sat,  1 Apr 2023 19:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=t4m3mn7v7zpr6jas7yz4ivc4rozilcmo; d=kernel.org; t=1680376128;
	h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:To:Date:Message-ID;
	bh=dDsqvazCxQngJO+WwlMjgAWT3GsG0zNOT4GL44SfxgU=;
	b=ld/miRVas4VvP3+rziZBodgeuBkNE2tq6OS4qSuCnZ09SeWIc6MH99UtBhftteIf
	sxb47QGDJ9ly1jQptxFOIiOy+JhGdkVLR9FzsNGfJ5jOYiaUhlhIKfnOLYMse1CaHGm
	T+5M3HWdHCmyv7lcJBcRRio8nOurY1TZai5i1FeE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1680376128;
	h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:To:Date:Message-ID:Feedback-ID;
	bh=dDsqvazCxQngJO+WwlMjgAWT3GsG0zNOT4GL44SfxgU=;
	b=fmmbeZgO/sHgkDpqwel36uzcYywTu5au75h1E/BlGY6JC6roxYufvkioChOEdJee
	keox5Z8/3pERbb2R56QjgyQ4Rsm4lqbzdcMApcbyzS8EW8HD/almNyAj/BcDtNbA4MW
	x3iVxnF71aLIH6Dwt5Q/M08Yq5O2GChpaWKOb0L4=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Patchwork email address confirmation
From: patchwork@kernel.org
To: v9fs@lists.linux.dev
Date: Sat, 1 Apr 2023 19:08:47 +0000
Message-ID: <010101873e38e178-8270cfdd-bdea-4b00-89f2-00bf5a481e81-000000@us-west-2.amazonses.com>
Feedback-ID: 1.us-west-2.SRWGI0StfyVnjbk6m2dk6vieITagDnHZBvJJLHTOjxo=:AmazonSES
X-SES-Outgoing: 2023.04.01-54.240.27.188

Hi,

This email is to confirm that you own the email address:

  v9fs@lists.linux.dev

So that you can add it to your Patchwork profile. You can confirm this
email address by visiting the url:

 http://patchwork.kernel.org/confirm/04b8e1abf3c0af5394ccd2629a2e25e746d3b88a/

Happy patchworking.
