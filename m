Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86BB303A24
	for <v9fs@lists.linux.dev>; Fri, 10 Oct 2025 21:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760132550; cv=none; b=nssm3OfaZc/UQ3/T+vUYV5TNShXg4qDBLXUTuNFWdMa3vupPZnYU3YylmiBDQdjx+EC7dS6rwPaINluRFlH/mCP1sZt5TFc4pTtudgortJXmebOUG84vMNups7KrikH9aUE39dtL97vY/BjqpSR8LiW5aMPWMTTOSVQijYgUcP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760132550; c=relaxed/simple;
	bh=MYeYUOWONOAmTQBQ93bnEG0aCfx6bBELfUwwtyo7k8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=H8e/Ed+/5caBVWcNBc9INj05A1ARO1BSX4e6+6JX9Xzycz/zu1ch+f8iDXnEBkDjlyhZ3W+7BYNC/J3ZS+xR0wfj5oi7+XFBwmomXoxsfJ0Lj3Dv5AkfbmYfJ+Ct43qZdoa7wEZyN01PmrM6RxzLMFOyAyP0ylPH94wz1fWc2/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L6YOe59q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6YOe59q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760132547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7eg/CINfrFrBJA39F50UqdpcgBBZOmozNU38K2khzkQ=;
	b=L6YOe59qy5x5eTs9oV/7w7/Vf6B+5Xw9OFMfk8FjhNZqh5YQgpVbePr9489ZWVPIlEWpnw
	IHKtlUNbUDwIE0z4TTLqX+W0eqya9X9kx7Zwi2AwB5kUODp4Lz7hvtUmagqT2ZvJxRk+bh
	7pSdVSZn3PueALLHPrId9gW56aYFI/E=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-LCf0krLaMWqdnJ7xe-S1UA-1; Fri, 10 Oct 2025 17:42:26 -0400
X-MC-Unique: LCf0krLaMWqdnJ7xe-S1UA-1
X-Mimecast-MFC-AGG-ID: LCf0krLaMWqdnJ7xe-S1UA_1760132546
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42f8a89bb47so100725745ab.2
        for <v9fs@lists.linux.dev>; Fri, 10 Oct 2025 14:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760132545; x=1760737345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7eg/CINfrFrBJA39F50UqdpcgBBZOmozNU38K2khzkQ=;
        b=jcLt+cGrzEIFwpW1OayhOd40xk/pZruFS6fn8S2V8c4hbraMF2Y0LnZUyQJgo7T2z7
         BNjHaL3ihegKrHFO3i6gWVmAwSFrPx+C9aroqphm7ODCO5Gr8PLAEina79au3xnNWEzi
         KlC+Nue4n5cW2dpAPBxNcQz9UKVgUBGVDL+tbqmGG1CKsPAmOV9JycqROpU8vvhmQSO0
         DSPJE2mGW8sPoiql37MoCOImQlrb8TMnt97kNIncKkjKKO/MCiKLI9Zui4ZNAQ2HrRAQ
         sr3kXPUwz3D6UgkeW42K5Z6ZS2W0Ju3QTEvLhU93yszj9tSzRn3RXnpBHzGQMmNc7MwJ
         P8gQ==
X-Gm-Message-State: AOJu0Yyc5f7hR7/sgJqLJdkWQTDjbxjS1O3tQ5XisquoHSeu+dJF+INh
	PfuWTZ/ifYllJuxxvV5uRlYwBvRipMas9Dz7x6FTDXxMpYBqQkXAvODMGMJjbjeyJxJ5xaJ8w6A
	Yu5IjIa5AEJ5bn5vRYxhlub1eTO9I2tBt2qbVbK9ABp2acmVOa1YdsVbBm29lF+JI60ugF2s0Pg
	6hz2WvWde3yUgPABV6MOAqtxoiDo/peRH93PYS4A==
X-Gm-Gg: ASbGncuA89C1yj54ltErPadJipuvk746ql4+yWUjKumQZgCt2WNoKJsDzgRlRWEXer8
	iqxfjplKHvnY3kVChMzVr65jK6RxUQhEN1HZa/awQXIAfWx2hHgajP0ceDbtwQntwZA1Mg0BCmf
	U/JSFhe7IQlh1fimyv2lUplzowgOHTDQ0TYhzds9TZWHbcEOhWr7DVtAsJBewPDPUjzxHfbent3
	DJLcq9EohelySS1Cy/etAiRlOEAiAqzCVF/faXnSUuwNGoee/U5hHiehfqwtGJx8vmfb5LSkmxT
	ZKuz3+lH+swfLa2Fc9HIB0SuHfe4YuMhygVB6043QFFgcKVEgfmk3M0=
X-Received: by 2002:a05:6e02:1a8e:b0:42f:9e92:a448 with SMTP id e9e14a558f8ab-42f9e92bb89mr43920165ab.7.1760132545251;
        Fri, 10 Oct 2025 14:42:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPevkN5ffI8mFRitJH+Wd+8sxBtluY9Wioh6i1ktRbeYTuurfFKYwJgHA2GryCcd6b5lP85A==
X-Received: by 2002:a05:6e02:1a8e:b0:42f:9e92:a448 with SMTP id e9e14a558f8ab-42f9e92bb89mr43919715ab.7.1760132544750;
        Fri, 10 Oct 2025 14:42:24 -0700 (PDT)
Received: from big24.xxmyappdomainxx.com ([79.127.136.56])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f9027855bsm24382895ab.11.2025.10.10.14.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 14:42:24 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	eadavis@qq.com
Subject: [PATCH V3 0/4] 9p: Convert to the new mount API
Date: Fri, 10 Oct 2025 16:36:15 -0500
Message-ID: <20251010214222.1347785-1-sandeen@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MlfUEBrx-ZLaanGiN06WZm_ocGwAOQfWEf-pd48O8Y0_1760132546
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This is another updated attempt to convert 9p to the new mount API. 9p
is one of the last conversions needed, possibly because it is one of the
trickier ones!

This has had only light testing. I confirmed that with the diod server,
both of these mount successfully:

# mount -t 9p -o aname=/tmp/9,version=9p2000.L,uname=fsgqa,access=user,trans=tcp 127.0.0.1 /mnt

and

# mount.diod localhost:/tmp/9 /mnt

(The latter passes trans=fd under the covers)

I have not been able to test other transports, or exhaustively test
functionality of all mount options.

Changes from V1 to V2:
        Address "make W=1" warnings from kernel test robot, comments from
        dhowells, and some kernel-doc comments for changed arguments.

Changes from V2 to V3:

Patch 1:
        None
Patch 2:
        None
Patch 3:
        Change to not re-use v9fs_session_info and p9_client in the
        v9fs_context structure. Instead, new structures p9_client_opts and
        p9_session_opts are introduced. This avoids confusion about what is
        used only for option parsing, and what is used for the actual
        mounted instance.
Patch 4:
        Allows unknown mount options as prior code did. I noticed that
        mount.diod passes a "rwdepth" option by default, which was ignored
        previously but breaks mount with strict unknown option rejection.

        Adjust variable names in v9fs_parse_param, v9fs_apply_options,
        and v9fs_init_fs_context to reflect new context structure and
        to clarify difference.

        Limit the msize option to INT_MAX as the old code did.

        Remove redundant v9fs_set_super function, set_anon_super is enough.

        Properly extract v9fs_seesion_info from sb->s_fs_info, not
        the fc context, in v9fs_fill_super. (thanks eadavis@qq.com)

        Remove unneeded fc arg from v9fs_fill_super.


