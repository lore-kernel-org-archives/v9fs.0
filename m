Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB9F30C60E
	for <v9fs@lists.linux.dev>; Fri, 29 May 2026 09:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780045873; cv=none; b=mvofU5FCEDtzyd5fCdqviLJz0wFe02wPudd3iKFwfs04qesUo7Z0bZUS7QVkSr4cdg+mFHT+GJPm1Z5q28ckryrcsrWdx7ZTzh/SlB0TbCm4T6wmmxExQNjsdpkb1+nxT4c8VCbStMIT3gpx1UW02/jYlBLAr8vRP1XbqlaIINA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780045873; c=relaxed/simple;
	bh=pmcCc5AdE8TlA3Tc8avm0TiFdH/zQOOX8qDFpkCpBTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IqTRX4mfQ5aCpyhTZN6PtP1dI0woC1PDrayx5KFilSOIEmKOKHHweDT4F4pCuXjLhiub0/TgI4Md3aFpaVrO8iZGbtKnWUrjDX0hQA1LpmPekk0XiRHNjUIxWyrHFfllwcI6Vq6uDN1yI+Yo20c23jk8y3a+eoKko9LdXd00jCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=qb/2d6lZ; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="qb/2d6lZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=xVagF
	CORyKig/ZwwgHiE4KYJoDaZcQ0cADU++/ybL9Q=; b=qb/2d6lZvLjSboo8lXID+
	N/YbO7WXJosfKTaADfP3WwckJ2Z8A+/B0paqWLw0FYgOGHfpgbNuXx91MB7n67vS
	n3Zv1mRD4fjMak8AHCJ++ZDPeHEQGOGG21NRQ2oF/B5pDbE37uXj+Oz4e+c27mIP
	nNaK+vjH3w+/X3gUbP2Vjk=
Received: from localhost.localdomain (unknown [211.102.241.99])
	by web2 (Coremail) with SMTP id yQQGZQAntZwjWBlq48LdAQ--.9949S2;
	Fri, 29 May 2026 17:10:59 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>
Subject: Re: [PATCH] 9p/rdma: create RDMA CM ID in caller's net namespace
Date: Fri, 29 May 2026 17:10:48 +0800
Message-ID: <20260529091050.78839-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQAntZwjWBlq48LdAQ--.9949S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF1fKF45Cw1Uury7GF15Jwb_yoW3JFX_CF
	Z3Wr9rCr1kZrWIvFs2kw18J3y8W348Z3ySg3yqqay7C3sYqrnrJFsFqrna9r47CFyfKa12
	9F42gwsxt3WS9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbDxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j
	6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwV
	W8uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUYPEfUUUU
	U
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAgACAWoZNcBhjgAAso

On Fri, May 29, 2026 at 03:08:15PM +0800, Dominique Martinet wrote:
> We apparently should use fc->net_ns[1] (likewise in other transports that
> use current->nsproxy->net_ns)
>
> [1] https://sashiko.dev/#/patchset/20260529070817.76798-1-zhaoyz24%40mails.tsinghua.edu.cn
>
> If you have time please send a (separate) patch fixing trans_fd.c ?

Thank you for the review!  You're right, fc->net_ns is the proper way.

Instead of sending a separate patch for trans_fd.c, We've folded the
trans_fd.c fix into the same patch and updated trans_rdma.c to use
fc->net_ns as well.  Please find v2 here:

  https://lore.kernel.org/v9fs/20260529090625.78761-1-zhaoyz24@mails.tsinghua.edu.cn/

Best regards,
Yizhou

