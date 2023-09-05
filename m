Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ABAD537
	for <v9fs@lists.linux.dev>; Tue,  5 Sep 2023 14:16:15 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9D9CC6732A; Tue,  5 Sep 2023 16:16:04 +0200 (CEST)
Date: Tue, 5 Sep 2023 16:16:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>,
	David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Lei Huang <lei.huang@linux.intel.com>, miklos@szeredi.hu,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Boris Pismenny <borisp@nvidia.com>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
	linux-mm@kvack.org, v9fs@lists.linux.dev, netdev@vger.kernel.org
Subject: getting rid of the last memory modifitions through gup(FOLL_GET)
Message-ID: <20230905141604.GA27370@lst.de>
Precedence: bulk
X-Mailing-List: v9fs@lists.linux.dev
List-Id: <v9fs.lists.linux.dev>
List-Subscribe: <mailto:v9fs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:v9fs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi all,

we've made some nice progress on converting code that modifies user
memory to the pin_user_pages interface, especially though the work
from David Howells on iov_iter_extract_pages.  This thread tries to
coordinate on how to finish off this work.

The obvious next step is the remaining users of iov_iter_get_pages2
and iov_iter_get_pages_alloc2.  We have three file system direct I/O
users of those left: ceph, fuse and nfs.  Lei Huang has sent patches
to convert fuse to iov_iter_extract_pages which I'd love to see merged,
and we'd need equivalent work for ceph and nfs.

The non-file system uses are in the vmsplice code, which only reads
from the pages (but would still benefit from an iov_iter_extract_pages
conversion), and in net.  Out of the users in net, all but the 9p code
appear to be for reads from memory, so they don't pin even if a
conversion would be nice to retire iov_iter_get_pages* APIs.

After that we might have to do an audit of the raw get_user_pages APIs,
but there probably aren't many that modify file backed memory.

I'm also wondering what a good debug aid would be for detecting
writes to file backed memory without a previous reservation, but
everything either involves a page flag or file system code.  But if
someone has an idea I'm all ear as something mechanical to catch these
uses would be quite helpful.
