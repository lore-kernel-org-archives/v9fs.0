Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 68E4079C6
	for <v9fs@lists.linux.dev>; Tue, 16 Jan 2024 03:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 732488 invoked by uid 1000); 15 Jan 2024 22:17:34 -0500
Date: Mon, 15 Jan 2024 22:17:34 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
  Latchesar Ionkov <lucho@ionkov.net>,
  Dominique Martinet <asmadeus@codewreck.org>,
  Christian Schoenebeck <linux_oss@crudebyte.com>,
  Jonathan Corbet <corbet@lwn.net>,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>, v9fs@lists.linux.dev,
  linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
  linux-usb@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/3] usb: gadget: function: 9pfs
Message-ID: <4856923e-3ce8-4372-9451-f9c8aa157111@rowland.harvard.edu>
References: <20240116-ml-topic-u9p-v1-0-ad8c306f9a4e@pengutronix.de>
 <20240116-ml-topic-u9p-v1-1-ad8c306f9a4e@pengutronix.de>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116-ml-topic-u9p-v1-1-ad8c306f9a4e@pengutronix.de>

On Tue, Jan 16, 2024 at 02:49:41AM +0100, Michael Grzeschik wrote:
> Add the new gadget function for 9pfs transport. This function is
> defining an simple 9pfs transport interface that consists of one in and
> one out endpoint. The endpoints transmit and receive the 9pfs protocol
> payload when mounting a 9p filesystem over usb.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  Documentation/filesystems/9p.rst     |  12 +
>  drivers/usb/gadget/Kconfig           |  11 +
>  drivers/usb/gadget/function/Makefile |   2 +
>  drivers/usb/gadget/function/f_9pfs.c | 849 +++++++++++++++++++++++++++++++++++
>  4 files changed, 874 insertions(+)
> 

> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index b3592bcb0f966..72cdecaef6aa9 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -153,6 +153,10 @@ config USB_F_ACM
>  config USB_F_SS_LB
>  	tristate
>  
> +config USB_F_9PFS
> +	tristate
> +	select NET_9P
> +
>  config USB_U_SERIAL
>  	tristate
>  
> @@ -363,6 +367,13 @@ config USB_CONFIGFS_F_LB_SS
>  	  test software, like the "usbtest" driver, to put your hardware
>  	  and its driver through a basic set of functional tests.
>  
> +config USB_CONFIGFS_F_9PFS
> +	bool "9pfs over usb gadget"
> +	depends on USB_CONFIGFS
> +	select USB_F_9PFS
> +	help
> +	  9pfs support for usb gadget

This may be a dumb question, but what is the purpose of this CONFIG
symbol?  It doesn't get used by any of the patches in this series, as
far as I can see.

Alan Stern
