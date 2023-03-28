Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F1728FA
	for <v9fs@lists.linux.dev>; Tue, 28 Mar 2023 12:26:35 +0000 (UTC)
Received: by mail-yb1-f177.google.com with SMTP id j7so14779465ybg.4
        for <v9fs@lists.linux.dev>; Tue, 28 Mar 2023 05:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=contractor.linuxfoundation.org; s=google; t=1680006394;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N8PY0SIFxtbN9jeNP+zrrFoxbx5P3sMp3YrCMB/2dQI=;
        b=bx2eWshbkXVWbpOsEJWBCDgH+jypqHEUI0eJxg0JjjoY2+2dqY4k3KWSeexBkP4GGp
         vlO6Xig977sONJ+J8OXhkCX9/1DvGRb9atgKKA6/sg28fFy4rwoKFXJXeCcTKl8LiINF
         jhFBbe6ZbLixllXLEyJEAfFVcWTrXkoGzc4DFHevpSTrj4ORU5eh8NQW6M2gultWMdsr
         TycC/AMFyrNQ1K5tnyv1uti1AZ2DPIL+G0xUPCP+6MjjwuorF2An24054xMBUjfcBj7T
         SDu4UIzvklSnRm+SnGM8et0/+7Yk2lpKq7nhz2blEQK56/LQvkT+d/a2kYsK9/AIVev4
         d/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680006394;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N8PY0SIFxtbN9jeNP+zrrFoxbx5P3sMp3YrCMB/2dQI=;
        b=mJlPbm987C8cvEVcE62nSdaxCm+wDnMeDSFGH6r4WvRZd6DvSuqkaZghf6ltbOTuvI
         C6auH2rjGfkTxRNGXYgc+KJCzdMEfI1kApoNgQMw0C6xP2QMZFJ0GHY2Nq0HLbfAWg10
         7LFkjIMR1wWJL+GD0USpce9h6lU/VGEP4aN0ktPsBzU3tgsgIkrQlKJ4Wdc0AztzhOOu
         8Qk+0+W9ZM6NfAs+4djCosoClcPjVjHgXpxzBAEkpjVb57afdIzWNDCvfbvp2eBJfaxb
         Ysd3Aqr9xZMNmxQSEAtDXsL3aeczFuwj7mpcWEUItjoI+auQJlIciAlBEq49boOf8lXR
         W8vw==
X-Gm-Message-State: AAQBX9eAViygV9o6ZpqUyuJm/Mz+9dH73OLVHZ6QfwFNt1Z/aSJzr96M
	O4aVlQ2jxbC3YPPWtIT0XIpadKVOhKCRvqbkrdjzRKPgZlvZhBhVUBk=
X-Google-Smtp-Source: AKy350Y+0QXSfOXDUS0u4IUMoPrvGiVB2tsf8NlgIKyqpICL+qqKiN8YLCHzQ682KuIc019Im+BnClKGOosC8+jv9n0=
X-Received: by 2002:a25:840a:0:b0:b26:884:c35e with SMTP id
 u10-20020a25840a000000b00b260884c35emr10064999ybk.4.1680006394137; Tue, 28
 Mar 2023 05:26:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Shyam Kumar <skachukattu@contractor.linuxfoundation.org>
Date: Tue, 28 Mar 2023 17:56:23 +0530
Message-ID: <CAH=dH9_wRemVX36ZORMUeGxv0sxaeSkhK9L4bbwWAee7FeD5oA@mail.gmail.com>
Subject: Test Mail
To: v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

This is a test message to test successful delivery and start the
 archive for the list. Please ignore.



-- 
Regards
Shyam Kumar
The Linux Foundation Core Projects
