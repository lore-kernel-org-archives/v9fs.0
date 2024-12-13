Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446ED19007F
	for <v9fs@lists.linux.dev>; Fri, 13 Dec 2024 07:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734074836; cv=none; b=huMlAyo0iF+cCJmRY5J520Q7irlYiRGoFGW7Y/LTvPMJ9IizTN+aDFoXX8mMgmWxz3j98NCwYxLAB39lQ6NArY/TiwebEyotWXeBYUTEhZFuinB7Zmr4POpHO0FbDnX8gZbAr2Prbko4BlNcxpFWOjJwW6qoa2lS0dUs9lGQvig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734074836; c=relaxed/simple;
	bh=fWkBlWpo9o/6W90lOS1o8aqPGNjst66iRAXtFEWx2PY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGiHSd97w0QbSnVmqlgvCUpxbAOXlGElde3of8IWVxQpEgcCnIgfAmoEveb2R7LEdJt07lxqRzgcM+zcp9OO3Ws2QipvVjIN/4byWkRVPxsKNTZaFOldzzDDtC3BxyBIpIC82SyFdSmLEhfrWD6E2d1BO6z6ZHFvG3MkIRaUieg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD51a1L001159;
	Thu, 12 Dec 2024 23:26:56 -0800
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cx1u6tx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 12 Dec 2024 23:26:56 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 12 Dec 2024 23:26:55 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 12 Dec 2024 23:26:51 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <dhowells@redhat.com>
CC: <asmadeus@codewreck.org>, <brauner@kernel.org>, <ericvh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux_oss@crudebyte.com>, <lizhi.xu@windriver.com>,
        <lucho@ionkov.net>,
        <syzbot+1fc6f64c40a9d143cfb6@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>, <v9fs@lists.linux.dev>
Subject: Re: [PATCH] netfs: If didn't read new data then abandon retry
Date: Fri, 13 Dec 2024 15:26:51 +0800
Message-ID: <20241213072651.1475826-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2133166.1733759584@warthog.procyon.org.uk>
References: <2133166.1733759584@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=H/shw/Yi c=1 sm=1 tr=0 ts=675be1c0 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=RZcAm9yDv7YA:10 a=20KFwNOVAAAA:8 a=_HjyD2lY4jCciDRJ1kwA:9
X-Proofpoint-ORIG-GUID: 1zFU_zYCelM2ko5GnrQK31GXHGref2uG
X-Proofpoint-GUID: 1zFU_zYCelM2ko5GnrQK31GXHGref2uG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_02,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1011
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412130051

On Mon, 09 Dec 2024 15:53:04 +0000, David Howells wrote:
> David
> ---
> commit d0906b4a4611709c02de610d3c34d6172aa28aaf
> Author: David Howells <dhowells@redhat.com>
> Date:   Fri Nov 8 11:40:20 2024 +0800
> 
>     netfs: Work around recursion by abandoning retry if nothing read
>     
>     syzkaller reported recursion with a loop of three calls (netfs_rreq_assess,
>     netfs_retry_reads and netfs_rreq_terminated) hitting the limit of the stack
>     during an unbuffered or direct I/O read.
>     
>     There are a number of issues:
>     
>      (1) There is no limit on the number of retries.
>     
>      (2) A subrequest is supposed to be abandoned if it does not transfer
>          anything (NETFS_SREQ_NO_PROGRESS), but that isn't checked under all
>          circumstances.
>     
>      (3) The actual root cause, which is this:
>     
>             if (atomic_dec_and_test(&rreq->nr_outstanding))
>                     netfs_rreq_terminated(rreq, ...);
>     
>          When we do a retry, we bump the rreq->nr_outstanding counter to
>          prevent the final cleanup phase running before we've finished
>          dispatching the retries.  The problem is if we hit 0, we have to do
>          the cleanup phase - but we're in the cleanup phase and end up
>          repeating the retry cycle, hence the recursion.
>     
>     Work around the problem by limiting the number of retries.  This is based
>     on Lizhi Xu's patch[1], and makes the following changes:
>     
>      (1) Replace NETFS_SREQ_NO_PROGRESS with NETFS_SREQ_MADE_PROGRESS and make
>          the filesystem set it if it managed to read or write at least one byte
>          of data.  Clear this bit before issuing a subrequest.
Will there be conflicts when reading and writing use the same flag to mark?
>     
>      (2) Add a ->retry_count member to the subrequest and increment it any time
>          we do a retry.
>     
>      (3) Remove the NETFS_SREQ_RETRYING flag as it is superfluous with
>          ->retry_count.  If the latter is non-zero, we're doing a retry.
>     
>      (4) Abandon a subrequest if retry_count is non-zero and we made no
>          progress.
>     
>      (5) Use ->retry_count in both the write-side and the read-size.

BR,
Lizhi
