Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2146141C65
	for <v9fs@lists.linux.dev>; Mon,  8 Apr 2024 01:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712540713; cv=none; b=lmhqaCv1Kj8BOAxdg+hz9qPG5hm0WpldpO6c0oA1jvEMwjx1A8FmayVbGqKyW2RDYrriwpiNHPnUhPL+f1oB3H72+Hsi6mHJdY8M09FsUictkZegaDiEJ5EvDTI5+1+G5Btgg2+dBEGg1JyR4ij400MS1h0GTssW1EZGMEQFzbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712540713; c=relaxed/simple;
	bh=wFs54NwU7NWQaQLlmjlYoIKoww7BFhi7yPF1W80wjo8=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=IrvR+MBYa+kNVpl1ZwtUPZFGXOCiUqmlvPoLMNmNJqPr9WablXbbRLun3mw1PXF5O/GfPMg7ppYTVVT6GnoEETzCOB7809x9rRGrKuSK9eoW+ho/vuc70AwVgyVh68RO2pqgw+6FbPlnQ7aabBbFAoLzUUeayNzQak86yEvmRsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cjHhK74H; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cjHhK74H"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712540708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yGdDj8T1//1rHhHTmDullgHnlP4c6BWCMXRFnQ2nqTs=;
	b=cjHhK74HmyH6cvKY3QISxY5W++Rzf1LJxDnhYu83UkJLv7//4M7P9EHTWdUcxyAkMbWtSU
	/akP4cNkqYMW+PDITRqrIRtXn2CpT9eic7feux3/OR8WUtDF124jSzQ935ECraxfw7Avel
	1jIy7OUMA9gNv+2TaU4a7/Um8TdDVIo=
From: Itaru Kitayama <itaru.kitayama@linux.dev>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: ftruncate fails
Message-Id: <E7D462A2-EE93-4A57-9F15-8565EE1567F3@linux.dev>
Date: Mon, 8 Apr 2024 10:44:51 +0900
To: v9fs@lists.linux.dev
X-Migadu-Flow: FLOW_OUT

Hi,
With a recent kernel I see below program fails (Bus error) if executed =
from 9p mounted directory, not with the local filesystem (Ext4).


#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <linux/memfd.h>

int main() {
        char filename[] =3D __FILE__"_tmpfile_XXXXXX";
        int fd, size;
        size =3D getpagesize();
        fd =3D mkstemp(filename);
        if (ftruncate(fd, size)) {
                printf("error");
        }


}=
