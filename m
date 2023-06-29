Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABE313AC3
	for <v9fs@lists.linux.dev>; Thu, 29 Jun 2023 17:25:20 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-98e109525d6so165920966b.0
        for <v9fs@lists.linux.dev>; Thu, 29 Jun 2023 10:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688059518; x=1690651518;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnhlLZPHjVW5K8grBRsw1MvJ0F0O78p/eSVkX/pW4g4=;
        b=TsbH3N1xHDBN69X8isBdCRLKda4JDGRm4vya39GZNh05xCIQFYpmft2AnkosX0yp/g
         xtrn9br2zNGRh+BTOu695kGEsEN8gqZedGzhtHA/HEdyDgEXeLkYQ+mwQzFPu2nlzDyq
         AlunVp1I5Qe/Iekovd44KCwP1pMGcUKH2DOrMCOW7+D5o1zsaGAvh9v+ruCPmPjoJcHt
         Bv+UsniuVQT8cfZ2f9xGdLu6V95lXGx+b8yBgvmM5CW2p/CCI+sLu3k3WOXdsAuUw39K
         aR0TwZWADz0xRh7DK6B117jCF+IlINyjiw1zvrgqrjqN/fyOacnxD8w9FOGoTS0Yr9l8
         K1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688059518; x=1690651518;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mnhlLZPHjVW5K8grBRsw1MvJ0F0O78p/eSVkX/pW4g4=;
        b=A0N+RfF/AwejVu25+ZtPpnxMtFhOozDS4vbGJqcAfpG7lJjH4bgqZQt/gFzwGGtC9x
         hXCtj5U7Per8S22NtdYIFYF/C59tBa6ikLPVYt0e2PzAlxZj0rT16O3XpVhJAeUO64mn
         /riB4NvJwUbQi4FJC/qgYNgvfWhBIDmU8VAm5hRp4B+8kgUlXDonadbbstuZwLY0+atM
         YOwg3jqHVOURtklPrgGhMGu7BGsNz+3n1BwNB0tbmHR9oZWpQolTNiugGmLLnkYVO8I+
         9yE7POgHHye291wUprWuCoYk38o0UH9j7OMnozeHgO1wrSYgAUwM0VmK14Mz278bFlHd
         MzGA==
X-Gm-Message-State: ABy/qLa5Mhjs1bfjm7SsGhJXGy9P0ENJXe75sqe2sZ4sUzein7rEH/2m
	0rjScZSYxcMo+BoQxPQDDf4tx7X0lMAtR0RUaDQPCMRj
X-Google-Smtp-Source: APBJJlGWvGJiYOANDpadw8I013LkyJ2SkpXj5FhB98dAX2zVR7SJWb3teVbDC4AqeEzB6UgSLqL8Xw==
X-Received: by 2002:a17:906:2a48:b0:98e:2413:952f with SMTP id k8-20020a1709062a4800b0098e2413952fmr535836eje.18.1688059518446;
        Thu, 29 Jun 2023 10:25:18 -0700 (PDT)
Received: from [10.120.18.108] ([84.17.46.13])
        by smtp.gmail.com with ESMTPSA id w10-20020a170906130a00b00992b50fbbe9sm753723ejb.90.2023.06.29.10.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 10:25:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------Yuq101Ls3bV7W6Atdhf6Ge5p"
Message-ID: <77a92899-5eb0-8064-26a1-369744829cf9@tessares.net>
Date: Thu, 29 Jun 2023 19:25:16 +0200
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: 9p: MPTCP tests regressions due to new 9p features in v6.4
Content-Language: en-GB
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: v9fs@lists.linux.dev
References: <855a232a-76d3-7e7b-b2b5-2ebc41bcadd6@tessares.net>
 <CAFkjPTms30OO-p1-RyhAXKUXmavWQuJku+J-J-d-eqOz=Emkmg@mail.gmail.com>
 <df1fcb9b-27d0-8e64-34fa-e8d480c31721@tessares.net>
 <CAFkjPT=QLwyw+Pin-s-oqPPd6v++ibq21kj9FsGGHbL8S1cVVw@mail.gmail.com>
 <34d5623d-b7e7-aa9e-88fb-42cb9993bc0e@tessares.net>
 <CAFkjPTk_7ceY5495Ro0BdLVwN_xKQG-um0ny=5PrZOwYXjM1vg@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CAFkjPTk_7ceY5495Ro0BdLVwN_xKQG-um0ny=5PrZOwYXjM1vg@mail.gmail.com>

This is a multi-part message in MIME format.
--------------Yuq101Ls3bV7W6Atdhf6Ge5p
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/06/2023 19:04, Eric Van Hensbergen wrote:
> inline
> 
> On Thu, Jun 29, 2023 at 6:42 PM Matthieu Baerts
> <matthieu.baerts@tessares.net> wrote:
>>
>> Hi Eric,
>>
>> On 29/06/2023 17:17, Eric Van Hensbergen wrote:
>>> one thing that may be worth taking a look at in your test environment
>>> is confirming that there is no "accidental access" to the synthetic
>>> file systems (/sys or /dev) via 9p -- usually the /dev ones wouldn't
>>> be problematic, but if they were being accessed via 9p that may be a
>>> corner case perturbing performance in a way we don't typically test.
>>
>> Interesting, I didn't even know it was possible to do that :)
>>
> 
> Well, there is a special mode which usually isn't enabled on mount which
> is nodevmap which does allow you to access the devices on the host,
> without that, even if you were accessing devices on the host file system,
> they should still be serviced by the devices inside the vm.  sysfs a bit
> more complicated as those are treated as files.  But from your mount
> list, it looks like you have stuff mounted in a way that shouldn't be a
> problem.  Thanks for cross-checking, its one less thing to worry about.

Thank you for the explanation! That's nice to see how much we can do
with 9p, thank you for that! :)

> The conference I am at with horrible internet is over tomorrow so
> perhaps I'll be able to get a proper virtme / mptcp regression
> environment going over the weekend to try and continue to drill down
> on what might be the problem.
> In the meantime I'm fixing up my own regression infrastructure to
> start recording latency information to make sure we aren't getting any
> performance regressions from either latency or bandwidth as we
> continue to work on 9p in the future.

Thank you!

On our side, there is no hurry, we have a revert of the patches from 9p
from v6.4 in our tree for the CI to be happy. (But I don't know the
impact others might have: in my case, it was not obvious to see the link
with 9p :) ).

The only drawback is that I'm maintaining this branch with the revert
and I have to handle conflicts issues in 9p myself in a code I don't
know but I think it is fine for the moment :)
Recently I got a merge conflict with commit c829d0bd33ac ("9p: Add
splice_read wrapper") that recently landed in Linus tree and I had to
apply the patch attached to this email and visible there:

https://github.com/multipath-tcp/mptcp_net-next/commit/be007e248783

The CI looks happy so far so I guess/hope it was the right modification :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--------------Yuq101Ls3bV7W6Atdhf6Ge5p
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-9p-P9L_DIRECT-flag-is-not-available.patch"
Content-Disposition: attachment;
 filename="0001-9p-P9L_DIRECT-flag-is-not-available.patch"
Content-Transfer-Encoding: base64

RnJvbSBiZTAwN2UyNDg3ODM0YTNjZDdmN2Y0M2YxODYzYjY4N2MxMmM2YzJlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNYXR0aGlldSBCYWVydHMgPG1hdHRoaWV1LmJhZXJ0
c0B0ZXNzYXJlcy5uZXQ+CkRhdGU6IFRodSwgMjkgSnVuIDIwMjMgMTU6NDI6NDUgKzAyMDAK
U3ViamVjdDogW1BBVENIXSA5cDogUDlMX0RJUkVDVCBmbGFnIGlzIG5vdCBhdmFpbGFibGUK
ClVzaW5nIENBQ0hFX01NQVAgaW5zdGVhZCwgc2ltaWxhciB0byB3aGF0IGhhcyBiZWVuIGRv
bmUgaW4Kdjlmc19maWxlX3JlYWRfaXRlcigpIGluIGNvbW1pdCAxNTQzYjRjNTA3MWMgKCJm
cy85cDogcmVtb3ZlIHdyaXRlYmFjawpmaWQgYW5kIGZpeCBwZXItZmlsZSBtb2RlcyIpLCBo
b3BlZnVsbHkgdGhlIHJpZ2h0IHRoaW5nLi4uCgpTaWduZWQtb2ZmLWJ5OiBNYXR0aGlldSBC
YWVydHMgPG1hdHRoaWV1LmJhZXJ0c0B0ZXNzYXJlcy5uZXQ+Ci0tLQogZnMvOXAvdmZzX2Zp
bGUuYyB8IDQgKysrLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL2ZzLzlwL3Zmc19maWxlLmMgYi9mcy85cC92ZnNfZmls
ZS5jCmluZGV4IDY4NWIyNzcyNTkxMy4uODI4N2IyNmIyM2RjIDEwMDY0NAotLS0gYS9mcy85
cC92ZnNfZmlsZS5jCisrKyBiL2ZzLzlwL3Zmc19maWxlLmMKQEAgLTM5NSwxMSArMzk1LDEz
IEBAIHN0YXRpYyBzc2l6ZV90IHY5ZnNfZmlsZV9zcGxpY2VfcmVhZChzdHJ1Y3QgZmlsZSAq
aW4sIGxvZmZfdCAqcHBvcywKIAkJCQkgICAgIHNpemVfdCBsZW4sIHVuc2lnbmVkIGludCBm
bGFncykKIHsKIAlzdHJ1Y3QgcDlfZmlkICpmaWQgPSBpbi0+cHJpdmF0ZV9kYXRhOworCXN0
cnVjdCBpbm9kZSAqaW5vZGUgPSBmaWxlX2lub2RlKGluKTsKKwlzdHJ1Y3Qgdjlmc19zZXNz
aW9uX2luZm8gKnY5c2VzID0gdjlmc19pbm9kZTJ2OXNlcyhpbm9kZSk7CiAKIAlwOV9kZWJ1
ZyhQOV9ERUJVR19WRlMsICJmaWQgJWQgY291bnQgJXp1IG9mZnNldCAlbGxkXG4iLAogCQkg
ZmlkLT5maWQsIGxlbiwgKnBwb3MpOwogCi0JaWYgKGZpZC0+bW9kZSAmIFA5TF9ESVJFQ1Qp
CisJaWYgKHY5c2VzLT5jYWNoZSA+IENBQ0hFX01NQVApCiAJCXJldHVybiBjb3B5X3NwbGlj
ZV9yZWFkKGluLCBwcG9zLCBwaXBlLCBsZW4sIGZsYWdzKTsKIAlyZXR1cm4gZmlsZW1hcF9z
cGxpY2VfcmVhZChpbiwgcHBvcywgcGlwZSwgbGVuLCBmbGFncyk7CiB9Ci0tIAoyLjQwLjEK
Cg==

--------------Yuq101Ls3bV7W6Atdhf6Ge5p--
