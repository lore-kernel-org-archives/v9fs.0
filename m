Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9883418953C
	for <v9fs@lists.linux.dev>; Thu, 26 Sep 2024 22:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727388629; cv=none; b=dpZId9Nm4iusCOBtMNPFgIeVm5mqYU25iYItFDMHiVGdD9O5HWmh4ylMEcBxfLAGV1ffHZCTn1thru6Tbquz6LqvWuKjxyxzYp4w0r68OgfHIhyNHmJMGDd6EcqT99g3AUnHMtRrgboxpSMisYx6WAOivw7tJdWHzJ3rydjitAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727388629; c=relaxed/simple;
	bh=G+L6BGRI1dQMplCLGhjNNKl68X658qh33Dvj/U6qwXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRWY7rUrX455uatNCV6NKTMvotIke4yC1gY4T0EIqKbxmAdWb//cLExWEn/6iwXpgKvhPJehGUyX/8yc/w3d6nN1txgekJ/23p6jUJ7n3LqEdR6kpzdVOvDZdevIpL155IFpO8p052t69E23ieuDfZjtSdvJAmZMEu7puYCp1G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPueh+Jd; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPueh+Jd"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a9aec89347so110067085a.0
        for <v9fs@lists.linux.dev>; Thu, 26 Sep 2024 15:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727388626; x=1727993426; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzolFJ9r7P6dC1Xh/Y6FYKRpWyNfvBP43rsrIRfwlv8=;
        b=RPueh+JdgDExY9tbtATjNXmDiFvtigMhkM6CwCOPczirtI48LgZCKIeuORUsJesfx8
         7QhO5sOcXADhTPnQm9fR4gtmHcjn/pcj31T+WBgFgivHtJTzubloUXitVEl9kLYeT3TU
         h7VWduE9rf6aVDWCFixu5qErQk4drYtx8MT8FL3iDCsaQalUDf8Z/Xo3NMn5q7gy4fvb
         pdD4U10IGQyIE2Frf+kGQKlK/lxaRHeJnuRVVAy/xQEh3jQTiKlhQR5cwP+TkFzbO7rD
         91Fse2gnaEO1lzNsH3aO1+JYtDssujwKkEbW7600ks24i3w59K3cjzUVshbeLT0p4+Yo
         Tvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727388626; x=1727993426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzolFJ9r7P6dC1Xh/Y6FYKRpWyNfvBP43rsrIRfwlv8=;
        b=f8CuZndCfk44pmFglKHksHuhDz6+2iC8KrVtbM8OXDD35nT8AGl+aC80M0+QOX8Di4
         sy2ZZNNDrj9tkzaN2FOrCyAxVj2NF+Lr0MKbBSTfeMZbazjiwrEnPMV2YA5fTBk9xh7g
         A1tAdQk8KlPpauz3IiNqGuCnHtngkZk3zwMbotFsykPcJ4TUUXUwz0tWTyuyTaBdN77w
         9O/uicDJwDy/q014jLmabA86PMTLGhRHJeiUIHArjlEKvY4UDAbKmL1EKKoIQfXXVvNU
         qFk9C8mzJ5K6AKf+gbF9/tDPXmdOHh6SH5wyewYBZKC+edcBggiC+dNGf/vqNxwLtDVE
         3G+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuwJDNWOjDMHk4DbaPU6wuNTl1XX6M/jMQMm1RmxcvhzcBOclK7IFKtgWcfOS8a/khikJB@lists.linux.dev
X-Gm-Message-State: AOJu0YyEEWAiDH+gKWCOlh4uPN3YdWncbm5/L/4uo9byhJqXrVFUSh00
	VVmKjqaYVfKUUvJ7goZaSNGjXnD8h6gYZ6DFmbiP4ZZdTvifKvUQKRDgV9bV7jie6pK511c+mES
	QaULFMZLNd8eK/OcEMfZQkwKU2ag=
X-Google-Smtp-Source: AGHT+IFz7MzXUpx/7skxhd/YFqB/RceGdY1NOSEf+hmf5J4yYDT2reFYBVxZMcnoTz3IOAXM4uHMf6zohfQgaqLHQO0=
X-Received: by 2002:a05:620a:17ab:b0:7a9:c13d:6e5c with SMTP id
 af79cd13be357-7ae37852751mr128385485a.29.1727388626322; Thu, 26 Sep 2024
 15:10:26 -0700 (PDT)
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
 <CAOQ4uxjyihkjfZTF3qVX0varsj5HyjqRRGvjBHTC5s258_WpiQ@mail.gmail.com> <CAOQ4uxivUh4hKoB_V3H7D75wTX1ijX4bV4rYcgMyoEuZMD+-Eg@mail.gmail.com>
In-Reply-To: <CAOQ4uxivUh4hKoB_V3H7D75wTX1ijX4bV4rYcgMyoEuZMD+-Eg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 27 Sep 2024 00:10:14 +0200
Message-ID: <CAOQ4uxgRnzB0E2ESeqgZBHW++zyRj8-VmvB38Vxm5OXgr=EM9g@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: Git clone fails in p9 file system marked with FANOTIFY
To: Krishna Vivek Vitta <kvitta@microsoft.com>
Cc: Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	"v9fs@lists.linux.dev" <v9fs@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 10:28=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> > > What would be the next steps for this investigation ?
> > >
> >
> > I need to find some time and to debug the reason for 9p open failure
> > so we can make sure the problem is in 9p code and report more details
> > of the bug to 9p maintainers, but since a simple reproducer exists,
> > they can also try to reproduce the issue right now.
>
> FWIW, the attached reproducer mimics git clone rename_over pattern closer=
.
> It reproduces fanotify_read() errors sometimes, not always,
> with either CLOSE_WRITE or OPEN_PERM | CLOSE_WRITE.
> maybe CLOSE_WRITE alone has better odds - I'm not sure.
>

scratch that.
I think the renames were just a destruction
git clone events do not always fail on a close+rename pattern,
they always fail on the close+unlink that follows the renames:

1776  openat(AT_FDCWD, "/vtmp/filebench/.git/tjEzMUw",
O_RDWR|O_CREAT|O_EXCL, 0600) =3D 3
1776  close(3)                          =3D 0
1776  unlink("/vtmp/filebench/.git/tjEzMUw") =3D 0
1776  symlink("testing", "/vtmp/filebench/.git/tjEzMUw") =3D 0
1776  lstat("/vtmp/filebench/.git/tjEzMUw", {st_mode=3DS_IFLNK|0777,
st_size=3D7, ...}) =3D 0
1776  unlink("/vtmp/filebench/.git/tjEzMUw") =3D 0

I know because I added this print:

--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -275,6 +275,7 @@ static int create_fd(struct fsnotify_group *group,
const struct path *path,
                 */
                put_unused_fd(client_fd);
                client_fd =3D PTR_ERR(new_file);
+               pr_warn("%s(%pd2): ret=3D%d\n", __func__, path->dentry,
client_fd);
        } else {

We should consider adding it as is or maybe ratelimited.

The trivial reproducer below fails fanotify_read() always with one try.

Thanks,
Amir.

int main() {
    const char *filename =3D "config.lock";
    int fd;

    // Create a new file
    fd =3D open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (fd =3D=3D -1) {
        perror("Failed to create file");
        return EXIT_FAILURE;
    }
    close(fd);

    // Remove the file
    if (unlink(filename) !=3D 0) {
        perror("Failed to unlink file");
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}
