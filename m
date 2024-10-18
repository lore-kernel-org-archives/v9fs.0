Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E657202F85;
	Fri, 18 Oct 2024 17:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729272491; cv=fail; b=S65xj2XuqBRUs+rkrShyp8hQ03rK27pzsu7ViNt3vNGZE6dmxaoXRWylxxq139mgRKL7+yNUwlyOUCmXRNQrzY2CUjVYC02oqQdSwiT8c3BhwxT0bUW+2+WfkJlqVR5BNTg2R95DPfN6/Il94Iw1sS+UdaNB1fy23SZvkAcTSaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729272491; c=relaxed/simple;
	bh=71zRTUNnRlZHnEhqe0T4Juj9DD7gi/oywLLgqPFJmqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M7421EYn2x61KrXZK3GH3Gs4B+YX27+eJIoqDGolDNQBHOHLDHu/lGtBIxgGJCt/sgl1kjr4yNXWhDz5mTTxCyBFfQN7/MzCYUzuueUVfoxUmkQY1jf6mlCJCUvV7FCYC3WiVxaxnXD1ahFBZrnZPQDXjDmIaNUu9TuyxeOYF9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mJoaxA8A; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mJoaxA8A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGDGdlEDxGFrjI7Ot9RJsre8vkXsXTe7Y1/1WCgCcDto99gIdQ1oDUlSsF6PftTYX8PxmL/YbyKHTUTIgZexXdoZgk3KEaTc32RDEB6ZNRJGgXcLhektEty5iZCRCSg7kbsxUlCTedMrK57YWM/sH3iSmvKGU0JqQxNgKk7BCDqKKp4X9JKOlW8qFnnNRizVSDkesrSlnabEZUbSLjN0RlwNVl3BNf//k0wDmtLmK2YLGNIqeFNJ/i5gGRccig880kUKjAdpOhMvSmknAUOIXBrJG5BHJc/TpHoVJzw1GZJDHR3Vd9bICOmOH2gVSEz5fyE00M3zxwny79LmczuRkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0FmyAlRf050MI0Bs08IodL5QdwM6Rl2TWsVmq2QpE4=;
 b=dv9ZvpEqOc56Ji/zn8FOecQFQocIB9+1KxXz588yT5kilc882qb6TufJAmfRwM6OUbmwFREh3GDtGQHkudggY17jhRrLIReyqx+k6b4OLpjaIV5CHzmpeKjWWE/lcuuI+9ypcfxK2C+74grLNmahZU+SEuHnroiayQGYNMHQFvPs1pPPyWTii2PYFNF7YJmVUHsdxB7k/a1bcTw5OVxcurRXClwVuhwkXaSpLrVeIeLOvAtaiYTp6dab55nyDGPsM8nvGDigcohpTn68wSGdzSt54+zsn2Xoopy522kb/XvJQnCfOjRjcspXCLmN3jm/c7NkT3QT/RMBm6gVEfog1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0FmyAlRf050MI0Bs08IodL5QdwM6Rl2TWsVmq2QpE4=;
 b=mJoaxA8ACQIA009rjaqFDKXWRuDy8AXH0yq+v15EhrKkPWyX4dbONLUvjdvAVq1DSOlY7340+GDsmIRLfClmsiWF2dU7bGmZjORwP2AxDtjg2uxHT+aje9gR8FKnp8j4j60lyoz/YbgOXswZ6ypnbsJrzOZPPVhpDaOekT/L/qqCecUwwIOEfyU7XXPOt2HPuIjqSaPuHOq0hjVwa4Z//mZ2NFuoI1X6p5/F03SJpPU5YjTh+cgGGptcYrJnVW6s3TuElkdNM2LhP5vJTCtxLYgK2zyBCKULG/YdOoqG1jA+WQ/nA0O8w24p1q21Usmo1AF9uu1B0wpWDye9Ws6SRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB6682.namprd12.prod.outlook.com (2603:10b6:303:1e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 17:28:06 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 17:28:06 +0000
Date: Fri, 18 Oct 2024 14:28:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH] 9p: Avoid creating multiple slab caches with the same
 name
Message-ID: <20241018172804.GA2151929@nvidia.com>
References: <20240807094725.2193423-1-pedro.falcato@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807094725.2193423-1-pedro.falcato@gmail.com>
X-ClientProxiedBy: BN0PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:408:ee::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: dd90fa96-694a-490f-b71c-08dcef9a3a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iXhDc8I8R9zz5Uh+CUp936PA7Dv7Kh5CKKTSBqbxg0EEaDNACgCJUXZB1wVa?=
 =?us-ascii?Q?iqiPCbqjPTdod8nTXGyQpvlDEJghQZKfDRHITP/xl/vbYgcy0p2MUnjTycY8?=
 =?us-ascii?Q?co/mZ0doP2d5MD7y7OYftU6El2x4/AnAMsj4SwoM58nPqMpvPjXoZe+WZR/q?=
 =?us-ascii?Q?w2REh5MIYmzJFCbwm1rWAZiprxYrrEiJ4X0m8CDGltcwBV4Sp2MXVO9U1zoH?=
 =?us-ascii?Q?2QRksNxcQ2GAL9WLiog8XtAyBlDUp1VgFUrn/W0kldaxWa9gX91CRBxgxTbf?=
 =?us-ascii?Q?zmOrktnD6tGoaGEEpAjCUb4VN/KTXiVnKX8WU/oL2FOZSoGWtjmIFI/ZZV5i?=
 =?us-ascii?Q?XBGz4e8VD2JSiiFMgYHCOiTH4gl3hewHNn4fPDQrV5O3s5Fj50eTaRNatVIF?=
 =?us-ascii?Q?LIHowGoD9DKzotj/B/GFoe2AStaN5W0rAxae4b4MsnBftN7JcBGHQuAPHSNb?=
 =?us-ascii?Q?4UnmIwwR2SqTvTrbXQ7UkqbHDmUBOqx3mmm7YZlw8kTRO/C9oiBe7eb0/WRa?=
 =?us-ascii?Q?Wk1cOUCNWTO2tCgLW0H8URr1tA/vu5aFDBJA6n83rKcWJ71FAmerrWYoenBe?=
 =?us-ascii?Q?queBYcWHBUaSeocnqXUfnXuBMn/sp+TRRBPQLyefo5YoiPLz8O+2a9dTQes6?=
 =?us-ascii?Q?atBCpC1bTHLNRO3IFcNEBwvUd3l8yEpOmuyZ33gxV327nmHkr9mptE1En39p?=
 =?us-ascii?Q?mgYsC47aNiZNUAl3IM2UVtfL91rT/1ytu9hIciLk1eJi92qO6/+fvasW65zg?=
 =?us-ascii?Q?2gG8qbXfGjHR/2+a6NasRt2JdVos6IglmGZ2aI60Rm8vIFzEKVHmLmzL+1hm?=
 =?us-ascii?Q?NJZVjP+Xll2GL9OvwHhkSH4YWd7fDqgGeG1dl/hlyaLdy5/6WuqyzAzoyPjQ?=
 =?us-ascii?Q?yaCeqFpbQLv9g16rpO34L4sqtRtBwyNpsR0THWz16rArVlAGAlz1JtPqcNEQ?=
 =?us-ascii?Q?NYE5DZNRv4Wh7sG+lAWYh7LTIoiVzJ5f/UiNXeq1g0k6NA9v9uxcezsvCQxJ?=
 =?us-ascii?Q?i1geSzVzHoIbIiXR8Ughg4CfuhTFU1+ys935QVj6xkh1aChk/YKsPQBi1ZGo?=
 =?us-ascii?Q?aVBB7vMq3MlghtrMKo3jgWzPPEMlqhsip0U8QhkkP7Ws/UVIgiHTbQT0q+21?=
 =?us-ascii?Q?zJ/LmOUCAKEkUJHc9DM9BWfguesI7X6kjRHHS06MqPIjqxkqhy9sfw3SdHCt?=
 =?us-ascii?Q?qpqW9S8zeeXzajQ8I8n2194AfMGIUhzwY4ZvleLge+4miDcsIarraeH7ZNmM?=
 =?us-ascii?Q?EIrGgo5HdUWNmvBR6rsVygtahL2yRYD9CeYu3ES0oF1wJ1UGRaIKslKiokjH?=
 =?us-ascii?Q?jA1TItnTJs/4q8FQ8HjY+U3T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mIswQkVAqc2p+eX36sLxucr/c78ZDUrply9aPHP9ZM0dQ3aNtw+3/jsBpAUn?=
 =?us-ascii?Q?Vvhv02aWqPF/mqOdT9kJ8tnmcaUdmiP13MCu+20zD23gCI9/BF1L6FSkRNU3?=
 =?us-ascii?Q?+jFHqulG0f6dJry0etcNcHDE0XyAbD8EBjRtlZ457BQUW2XEVKidzMglJDAS?=
 =?us-ascii?Q?BIhgkdUcsGZTWNU6laa10FDlDSRTGqQtAlRN8XPiHigEFWaSD2XpyIrJtL+u?=
 =?us-ascii?Q?DQcLZy4GJv2NlO+a3pkoBaR9E4p/6ckxZWLuiCYU3Cz1D+Who5pa1wOZsrUF?=
 =?us-ascii?Q?rNsGJ1JryEUs1CjwNhfrIvElRlb3u4WHcP3AMZX5Hr/9P+vTbulLep401rCA?=
 =?us-ascii?Q?fDIRpEEo/x1goOKx52yf5iT4SgL82QkKHDIErjY6Q8lv6fQDx9KRIXqW1Fw/?=
 =?us-ascii?Q?LBVLVVZEopg1Sk5+WMeoBR+zTs696bVjMhmsekBa+RGXTkzJSsx2Nq5UWzgG?=
 =?us-ascii?Q?/ORJjeaQBdhEMqN8Dd2BcYkVd1HyuPMnk2wvIKqYA2/pOMPk6IPsHW0etYo6?=
 =?us-ascii?Q?OG0NltqIhDN8rWmsFXmiKkD50/8XeDTQyjQlH04eAVAiNioGKFof4pz3hprC?=
 =?us-ascii?Q?hrBR7MwXpc2C46W0e3AFm5Sn87hSwNI/ezdyXbRMqsS5VviN7+w+W9xjjQnU?=
 =?us-ascii?Q?GMLg8q2x4qUUxyVfpuCfbBp5iDdWyCsJM9e+YgbZtg8VPPpe241/W0mKQ/W4?=
 =?us-ascii?Q?N+5ZlWSP+G2EVpxDrnOwVaIxYkGsVCly0/lUksN1PsV82g+ekkfuFdcARWcB?=
 =?us-ascii?Q?Cn4E8JT/1/VT0iTxaUSJxGK8ILlZqgXfea+wlQmuykv3CY83Q7RsQnq+0/7K?=
 =?us-ascii?Q?dU7SBDoNSPfi9pD5EAOuYdr191ahglndh5bLWAgEXuY26uQ+Kk33OCQyNwoU?=
 =?us-ascii?Q?SvyTKuRMW7MsjdiL0VsFeNpCHry4Aczr2iDdraj0J2jDsJwp5Yadzv0OsHeP?=
 =?us-ascii?Q?F7lgtuQCXQ6L6OrZbOVMCjpeSEYsB1VoujCXBrHEJfMVyGhYwEbiRu9hTfFP?=
 =?us-ascii?Q?mG/wlo3aCxO9xe9cdax0YrYeqCCvqq33i+cjrV8lIvx5ioqfOqsHb5EBMwwv?=
 =?us-ascii?Q?RNM2pP8Zky5o6NO0HAbccU0k4ClpZ+Dq5/+yHjx1KbnKsTnfi6U0/KhGZKdD?=
 =?us-ascii?Q?cOTnTbNn7AlZuuPsA/uqW/jK3G2ywfuoBIcekICxTdSS0kpIhT5lNAsEiQeQ?=
 =?us-ascii?Q?yigYS55WUmHAI+TSLihPVvtjD+OtAFKQSEFzhm90kJByCKprb8gadiPpf6tC?=
 =?us-ascii?Q?z1wWnamE+edXCXLpOCiQyIlqBtCYzPfMIJirST/wBReqilt0i7WxdgSLaPHY?=
 =?us-ascii?Q?vqfNFXkqkTto8y2wBXe0uat4XpdX3mhiaU+kBBtkUihOrjNTqzfLItU5Rjoy?=
 =?us-ascii?Q?eYwp9UmFE3Pb1uUIiXYrX3K9wwt/E5SGYwCcOaPEtJJvEJ5QSWCpFQzvMq5l?=
 =?us-ascii?Q?m+GXPDZSluBOqWFYLySKK2UDCA32Gi1Tt0xcqzSlJ006tLB7ddD4zLoWqDpZ?=
 =?us-ascii?Q?VKSvsxCsBwtYVVvBOzZZ5whl8sDnV/MxuvwAgliVPDi6p9+laxZdj6/WKtJ/?=
 =?us-ascii?Q?Z0bQw4pAivKS4HzlPa4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd90fa96-694a-490f-b71c-08dcef9a3a1e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 17:28:06.1832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXlncoDxGkVD8v8m24iL13by+m/+fcGEfT8+Z8LbttN2LeFqJdwUPq+a+Lg4KJOt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6682

On Wed, Aug 07, 2024 at 10:47:25AM +0100, Pedro Falcato wrote:
> In the spirit of [1], avoid creating multiple slab caches with the same
> name. Instead, add the dev_name into the mix.
> 
> [1]: https://lore.kernel.org/all/20240807090746.2146479-1-pedro.falcato@gmail.com/
> 
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> ---
>  net/9p/client.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Can this get picked up to rc4 please?

It is causing regressions in my environment

#regzbot introduced: 4c39529663b9

Thanks,
Jason
