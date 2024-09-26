Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E9A27473
	for <v9fs@lists.linux.dev>; Thu, 26 Sep 2024 20:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727382497; cv=none; b=lA1FefN1Uq0xobF8P6FeuGONr5ly9tzhyusp608tV8aBS1gqcoTw9A1scjhxa53Tagl3EivyiBUFKETmKJkjDf/f/PnUtvhgQHDEJqc0y2sevXx5Gi6VKkmNtq3QM6k2N4JhLWwNylFLbRhyNk6QkIlpvs+orZmpy4sVbhdzfto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727382497; c=relaxed/simple;
	bh=pknfZZZQcqqBmnB4YUw1rasAfvsUhrx+hscgFcM1NfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/PvBPmBM5HfW7++axD74SFv7R4jqP4eqX/6SSDUA+bEktZBjDbH+QzoMMTe5/5XWExKtZVgT2dBhwjdg3gKKeAZPJjbVMjl8oN6H+SAKx6G8+Yyar2qeqMOF7Vy4uZcO6bzXW6nKkVbzj3PNkDY0OPbGs79ZAnHvVSWbmzKYG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ext4MHvK; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ext4MHvK"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e25d6342837so731895276.1
        for <v9fs@lists.linux.dev>; Thu, 26 Sep 2024 13:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727382495; x=1727987295; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pknfZZZQcqqBmnB4YUw1rasAfvsUhrx+hscgFcM1NfM=;
        b=Ext4MHvK1r6PEvyRvxPv5zno69IILOGhi1SEh/OlZLKvAfsFgm7rs/2HWLWxRWAoZ+
         7BzjefYrk8O0I4q2tpaA8wkCDY7uFFxznBsMIz8Y4ALqQ2t+D7D3/BltcoRsRsQ27+My
         mmN5+VdnsdEIeUbHmPMOIh5gNP6e8HAeN6g7nvopsoSmuJwL0wbiZdh+RhCo+u2UKvLr
         GyIroKrYFv/35qCvxtS80osMmuzJsA1PMw+q2WBXGiZhVPrZ7PS2vPzo6ViIWIUUGsW8
         Fpz2Is63ZgqqIL6jqOC4B4YkmkIrRjRwXGpHM7w076PM4UTgv0tBsXmtZHkIG2o6jFqY
         sSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727382495; x=1727987295;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pknfZZZQcqqBmnB4YUw1rasAfvsUhrx+hscgFcM1NfM=;
        b=QItPzdIrMGijgdui3+Vuk7Tkum1s7zcwx3WO33GFUfDaHtI6OkX7/z/VdvU5xGs3F0
         dO7lNE/X/OaM69FqAY9MYI2VLWutHHOEoReXAg3Hex0evxbctXrYO+/vNLs9Gl2Bdfod
         J2KwPXygJOf3PhRL5ZgpnTxpIAG0nvAOf132JZc2FbROonaDVW5gLUdzGU2rG56H0oFw
         bMhR4LfHwmUTMsc5Tz10kR23LVG/8cU32Z+4wixGujWjzYop4Gtr0Kb6kLIjlObdvta2
         tVagdk2SQ2Oa5Z9eMIITQVSRLrocdJsHxEM+nySidqf3fhnw8MQqNrKv5Xm5NKMmMXWx
         epmg==
X-Forwarded-Encrypted: i=1; AJvYcCWBVEOYTLVCQzLwHXE431fh1DrNuugZWPXsCnG7NB9OG3jeR4JotVsIBbYxucSwoqC5tZFM@lists.linux.dev
X-Gm-Message-State: AOJu0YwMW+cT4Qp2H8vZEhoMnMj+yVNnMxb86/Oh27TbtVECRGd/jNNF
	r6bwNb0ddEvieMhznEIiwS1b5ifuFT/BI5KS3w+0ybX04XMAW5t9DjAlSWzZTvukoZAW36LBlhE
	5uy0k/b3oVp0DAh4CqcDS3Pju6BY=
X-Google-Smtp-Source: AGHT+IGBDy2RlG2XLotWUmR2bMly7Lt4Vd4mdCIC/hqNHTAu18kx/fUhOHB434FIoE0n7SUspusrRyC/zDShng7K5Q4=
X-Received: by 2002:a05:690c:2848:b0:6db:d5e8:d612 with SMTP id
 00721157ae682-6e247585df5mr7090797b3.23.1727382494998; Thu, 26 Sep 2024
 13:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxiuPn4g1EBAq70XU-_5tYOXh4HqO5WF6O2YsfF9kM=qPw@mail.gmail.com>
 <SI2P153MB07187CEE4DFF8CDD925D6812D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjd2pf-KHiXdHWDZ10um=_Joy9y5_1VC34gm6Yqb-JYog@mail.gmail.com>
 <SI2P153MB0718D1D7D2F39F48E6D870C1D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <SI2P153MB07187B0BE417F6662A991584D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <20240925081146.5gpfxo5mfmlcg4dr@quack3> <20240925081808.lzu6ukr6pr2553tf@quack3>
 <CAOQ4uxji2ENLXB2CeUmt72YhKv_wV8=L=JhnfYTh0RTunyTQXw@mail.gmail.com>
 <20240925113834.eywqa4zslz6b6dag@quack3> <CAOQ4uxgEcQ5U=FOniFRnV1k1EYpqEjawt52377VgFh7CY2pP8A@mail.gmail.com>
 <JH0P153MB0999C71E821090B2C13227E5D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxirX3XUr4UOusAzAWhmhaAdNbVAfEx60CFWSa8Wn9y5ZQ@mail.gmail.com>
 <JH0P153MB0999464D8F8D0DE2BC38EE62D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjfO0BJUsnB-QqwqsjQ6jaGuYuAizOB6N2kNgJXvf7eTg@mail.gmail.com>
 <JH0P153MB099940642723553BA921C520D46A2@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjyihkjfZTF3qVX0varsj5HyjqRRGvjBHTC5s258_WpiQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjyihkjfZTF3qVX0varsj5HyjqRRGvjBHTC5s258_WpiQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 26 Sep 2024 22:28:03 +0200
Message-ID: <CAOQ4uxivUh4hKoB_V3H7D75wTX1ijX4bV4rYcgMyoEuZMD+-Eg@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: Git clone fails in p9 file system marked with FANOTIFY
To: Krishna Vivek Vitta <kvitta@microsoft.com>
Cc: Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	"v9fs@lists.linux.dev" <v9fs@lists.linux.dev>
Content-Type: multipart/mixed; boundary="00000000000001b36e06230b9422"

--00000000000001b36e06230b9422
Content-Type: text/plain; charset="UTF-8"

> > What would be the next steps for this investigation ?
> >
>
> I need to find some time and to debug the reason for 9p open failure
> so we can make sure the problem is in 9p code and report more details
> of the bug to 9p maintainers, but since a simple reproducer exists,
> they can also try to reproduce the issue right now.

FWIW, the attached reproducer mimics git clone rename_over pattern closer.
It reproduces fanotify_read() errors sometimes, not always,
with either CLOSE_WRITE or OPEN_PERM | CLOSE_WRITE.
maybe CLOSE_WRITE alone has better odds - I'm not sure.

Thanks,
Amir.

--00000000000001b36e06230b9422
Content-Type: text/x-csrc; charset="US-ASCII"; name="rename_over.c"
Content-Disposition: attachment; filename="rename_over.c"
Content-Transfer-Encoding: base64
Content-ID: <f_m1jqwsjk0>
X-Attachment-Id: f_m1jqwsjk0

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3RkbGliLmg+DQojaW5jbHVkZSA8dW5pc3Rk
Lmg+DQojaW5jbHVkZSA8ZmNudGwuaD4NCiNpbmNsdWRlIDxzdHJpbmcuaD4NCiNpbmNsdWRlIDxl
cnJuby5oPg0KI2luY2x1ZGUgPHB0aHJlYWQuaD4NCg0KDQp2b2lkICp0aHJlYWQodm9pZCAqcHRy
KQ0Kew0KICAgIGNoYXIgZmlsZW5hbWVbMTBdID0ge307DQogICAgY29uc3QgY2hhciAqbmV3X2Zp
bGVuYW1lID0gImNvbmZpZyI7DQogICAgY29uc3QgY2hhciAqY29udGVudCA9ICJIZWxsbywgdGhp
cyBpcyBhIHRlc3Qgd2l0aCBmaWxlIHJlbmFtZSBvcGVyYXRpb24uXG4iOw0KICAgIGNoYXIgYnVm
ZmVyWzEwMF07DQogICAgaW50IGZkOw0KICAgIHNzaXplX3QgYnl0ZXNfcmVhZDsNCiAgICBpbnQg
Y291bnRlcj0wOw0KDQogICAgZnByaW50ZihzdGRlcnIsIlRocmVhZCAlbGQgc3RhcnRlZFxuIiwg
KGxvbmcpcHRyKTsNCiAgICBzcHJpbnRmKGZpbGVuYW1lLCJjb25maWcuJWxkIiwgKGxvbmcpcHRy
KTsNCg0KcmV0cnk6DQogICAgLy8gQ3JlYXRlIGEgbmV3IGZpbGUgYW5kIHdyaXRlIHRvIGl0DQog
ICAgZmQgPSBvcGVuKGZpbGVuYW1lLCBPX1dST05MWSB8IE9fQ1JFQVQgfCBPX0VYQ0wsIDA2NDQp
Ow0KICAgIGlmIChmZCA9PSAtMSkgew0KICAgICAgICBwZXJyb3IoIkZhaWxlZCB0byBjcmVhdGUg
ZmlsZSIpOw0KICAgICAgICByZXR1cm4gTlVMTDsNCiAgICB9DQogICAgaWYgKHdyaXRlKGZkLCBj
b250ZW50LCBzdHJsZW4oY29udGVudCkpID09IC0xKSB7DQogICAgICAgIHBlcnJvcigiRmFpbGVk
IHRvIHdyaXRlIHRvIGZpbGUiKTsNCiAgICAgICAgY2xvc2UoZmQpOw0KICAgICAgICByZXR1cm4g
TlVMTDsNCiAgICB9DQogICAgY2xvc2UoZmQpOw0KDQogICAgLy8gUmVuYW1lIHRoZSBmaWxlDQog
ICAgaWYgKHJlbmFtZShmaWxlbmFtZSwgbmV3X2ZpbGVuYW1lKSAhPSAwKSB7DQogICAgICAgIHBl
cnJvcigiRmFpbGVkIHRvIHJlbmFtZSBmaWxlIik7DQogICAgICAgIHJldHVybiBOVUxMOw0KICAg
IH0NCg0KICAgIGZkID0gb3BlbihuZXdfZmlsZW5hbWUsIE9fUkRPTkxZKTsNCg0KICAgIGlmIChm
ZCA9PSAtMSkgew0KICAgICAgICBwZXJyb3IoIkZhaWxlZCB0byBvcGVuIHJlbmFtZWQgZmlsZSIp
Ow0KICAgICAgICByZXR1cm4gTlVMTDsNCiAgICB9DQogICAgYnl0ZXNfcmVhZCA9IHJlYWQoZmQs
IGJ1ZmZlciwgc2l6ZW9mKGJ1ZmZlcikgLSAxKTsNCiAgICBpZiAoYnl0ZXNfcmVhZCA9PSAtMSkg
ew0KICAgICAgICBwZXJyb3IoIkZhaWxlZCB0byByZWFkIGZyb20gZmlsZSIpOw0KICAgICAgICBj
bG9zZShmZCk7DQogICAgICAgIHJldHVybiBOVUxMOw0KICAgIH0NCiAgICBidWZmZXJbYnl0ZXNf
cmVhZF0gPSAnXDAnOyAgLy8gTnVsbC10ZXJtaW5hdGUgdGhlIGJ1ZmZlcg0KICAgIGNsb3NlKGZk
KTsNCg0KICAgIC8vIE9wZW4gdGhlIHJlbmFtZWQgZmlsZSBhbmQgcmVhZCB0aGUgY29udGVudA0K
ICAgIGlmIChjb3VudGVyKysgPCAxMDApDQoJICAgIGdvdG8gcmV0cnk7DQoNCiAgICBwcmludGYo
IkZpbGUgc2F2ZWQgJWQgaXRlcmF0aW9uc1xuIiwgY291bnRlcik7DQoNCiAgICAvLyBQcmludCB0
aGUgY29udGVudA0KICAgIHByaW50ZigiQ29udGVudCBvZiAlczpcbiVzIiwgbmV3X2ZpbGVuYW1l
LCBidWZmZXIpOw0KDQogICAgcmV0dXJuIHB0cjsNCn0NCg0KaW50IG1haW4oKSB7DQogICAgcHRo
cmVhZF90IHRoWzEwXTsNCiAgICBsb25nIGk7DQogICAgZm9yIChpID0gMDsgaSA8IDEwOyBpKysp
DQoJICAgIHB0aHJlYWRfY3JlYXRlKCZ0aFtpXSwgTlVMTCwgKnRocmVhZCwgKHZvaWQgKilpKTsN
Cg0KICAgIGZvciAoaSA9IDA7IGkgPCAxMDsgaSsrKQ0KCSAgICBwdGhyZWFkX2pvaW4odGhbaV0g
LE5VTEwpOw0KDQogICAgcmV0dXJuIEVYSVRfU1VDQ0VTUzsNCn0NCg==
--00000000000001b36e06230b9422--
