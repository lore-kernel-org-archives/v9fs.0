Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA2B36656E
	for <v9fs@lists.linux.dev>; Tue, 18 Nov 2025 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482388; cv=none; b=AUkID/plS69/1kd77yA16oeBUTofB/r1tlHt6uwRMUMQSr+YR/3iwLRiZyvcMzSH1taYHIda6NKltKl/nzY6kVU/JnVwFJs3wm/nBL0PursUZanXsoS4grYFEys2H237JasW/GKIJtVB5EB33fN1zCbXana6UoqdAsmxNtdiPDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482388; c=relaxed/simple;
	bh=CgJJeq+h1xY5svP9byj2fQkiJep/myet5iK2e5cvz2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfyzOrhd2i8HfuPO6L8aGcoGW9NhibwfV/NYp65yyN3YSDOS3ucBC2R2G8SNyj6msqPlJD7GspUnZYi5rAKvxUmRe2PfslpN6SJqCgtKCD5GyHcmLzTSSirgOes1vhtPY8jwf6PzkwjURBsVFc0J0/zKouqNIEZZFCiHKCByX+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ddNL6h1u; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ddNL6h1u"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7355f6ef12so986827666b.3
        for <v9fs@lists.linux.dev>; Tue, 18 Nov 2025 08:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1763482385; x=1764087185; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRVFP3SF6tlEsY5Nv2afapjGwpyPg1ug4FgCZSzkX+g=;
        b=ddNL6h1udR8uaAzgyDvYezwWb1wkCnfBDScePXYjDKkcEemB8lyykMl3WTwjt6n+27
         JIVtpR/iMOKNLZA65sKglrCodSq99AvG8lTMIurJpH98Uu6mnRqZYiLTrm/XMHdQEEms
         qnGt811HmpIYZxXLuSlh8Q95x+YXIgFzt4SCT7etUhK5gGPaYYisIUWHfsLaI7OXFLH/
         Vm8fZwEci6WKCqKH37qQGmZSF1EpGI6RWBwIzHG6yNANGv0PSEOPpSPTXpexi6lXdM8Y
         TSHPsoKGRnPhs35bob3mXALAToN0bHq29sgv913VeoxeDLJ8tNbqaKpWySU/ZbEqppK5
         e2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763482385; x=1764087185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HRVFP3SF6tlEsY5Nv2afapjGwpyPg1ug4FgCZSzkX+g=;
        b=Omk2XteiewMBLJypJa8NsW+ItoZSFpOq7MqnlDrYYv1hxvQBuOw1t2TPP/eg0KX1co
         b/j8HDjVELtwBaMGq3ACoaN8lx53Gh4Wo4d/E0e+iOxo9BKvvrOImcHfmvyXRe/C3GOq
         cMb7AdnmUsozw9v/YTiRYb0IgxXug8MxSsPJvKP3E26vGZJzwNrFehVRro1t11tqb7dQ
         NnilZezc50wviieWAssumlFrzA7YX/Qt9K3L/fDFZWPCGClgmDAVlCH7hoZkvO8yHXTs
         vgawiei7hngEOG/9W8GaB99GDUwnkJ7gBhjlns6dRbFDY3ilDVO9hQdRd686N/Eo1lOj
         tTVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlHkUBdx52BUFmXewmFuqqmkhkz9bWI8RQliZOGZvyM0mr3iAvtLt21CPckcp4sb2YYuth@lists.linux.dev
X-Gm-Message-State: AOJu0YzoNM94uXsVbJlXAbWhxhsTmXDVbAYo+ceN3uHK3bALhZKOP14Z
	Br4UQNK5M04j/5e0FtzO6YzzX/SOX/O1wjJgmx8Wy8CDGXvr/8WcgmxUrLS+CokUm6qFEw3zKOH
	Ji5kM/suDDAjsMIzYdydIrSPXXU4biCAS4gm26Vl2YA==
X-Gm-Gg: ASbGncumKieni6obgf7wWga8BmdL1O4goRN149evueY9atK6+rdd+bODWHHJndt3tOB
	GHJdkfbO/0bPECw3MX7/T8dMEOoy52Sgd1G07D9/xwwIQtsjzUaqjEjP3hqK3TzaDaMmgle9y67
	sWay+HdL27s8cCvgOK9gfCeSVx5vKpoBtn0o94DQuJ5yKNnbsmLCcFEkti5d8sjcoSoWQ8v/wMj
	msNPXkE+sRaMCeaSQ/W46hFO2tH/nQdwbvZklN4sJbbSzM8UuRQSGOAdoS46juI5d3dH7jfg0n3
	Ki6Fap5FpNk4513pT/YyEIM3Ik+rbXgFFis=
X-Google-Smtp-Source: AGHT+IHqfQb8bMfcr5Qj87jqprg4qtWUghIGTyMSWqC2aB6cp4Vp6u5ZOOxI0YEXXLB/hLPH1O4n4SPgf8pKI0zDzMc=
X-Received: by 2002:a17:906:b74e:b0:b73:7bef:dab9 with SMTP id
 a640c23a62f3a-b737befdb8bmr1023780766b.39.1763482384592; Tue, 18 Nov 2025
 08:13:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <691bd66a.a70a0220.3124cb.00ae.GAE@google.com> <2200414.1763479511@warthog.procyon.org.uk>
In-Reply-To: <2200414.1763479511@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 18 Nov 2025 17:12:53 +0100
X-Gm-Features: AWmQ_blMuQ9oajfXjcTYBBLRYkbNTFBnJsLtVf0jNMQ5JSZHhcgEs7teQOeizac
Message-ID: <CAKPOu+-da_s=r2-1WynNkg024uxFE2PEHTp=9_uJP97fskvQyA@mail.gmail.com>
Subject: Re: [syzbot] [v9fs?] INFO: task hung in v9fs_evict_inode
To: David Howells <dhowells@redhat.com>
Cc: syzbot <syzbot+56bd5818697f0f93fdd9@syzkaller.appspotmail.com>, 
	asmadeus@codewreck.org, brauner@kernel.org, ericvh@kernel.org, 
	hdanton@sina.com, linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, 
	lucho@ionkov.net, syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 4:25=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> syzbot <syzbot+56bd5818697f0f93fdd9@syzkaller.appspotmail.com> wrote:
>
> > syzbot suspects this issue was fixed by commit:
> >
> > commit 4d428dca252c858bfac691c31fa95d26cd008706
> > Author: Max Kellermann <max.kellermann@ionos.com>
> > Date:   Thu Sep 25 13:08:20 2025 +0000
> >
> >     netfs: fix reference leak
> > ...
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D56bd5818697f0=
f93fdd9
>
> That sounds reasonable.  I don't know if Max has a blocked cpu message fo=
r
> comparison?

Indeed, that's the same symptom I had; my patch is the fix.
Unfortunately, I don't keep any of the debugging output - I should
have added that to the patch description.
