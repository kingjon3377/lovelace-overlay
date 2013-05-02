# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2

DESCRIPTION="Comressed FUSE implementation"
HOMEPAGE="http://www.miio.net/wordpress/projects/fusecompress/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/tex/fusecompress.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+bzip2 +lzma +lzo +zlib"

RDEPEND="
	>=dev-libs/boost-1.33.1
	bzip2? ( app-arch/bzip2 )
	lzma? ( >=app-arch/xz-utils-4.999.9_beta )
	lzo? ( >=dev-libs/lzo-2 )
	zlib? ( sys-libs/zlib )
"
DEPEND="${RDEPEND}"

src_configure() {
	econf \
		$(use_with bzip2 bz2) \
		$(use_with lzma) \
		$(use_with lzo lzo2) \
		$(use_with zlib z)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS NEWS README TODO
}
