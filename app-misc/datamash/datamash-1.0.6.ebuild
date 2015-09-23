# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/datamash/datamash-1.0.6.ebuild,v 1.3 2014/02/24 02:15:30 phajdan.jr Exp $

EAPI=5

inherit toolchain-funcs

DESCRIPTION="GNU datamash - a statistical processor for text streams"
HOMEPAGE="http://www.gnu.org/software/datamash"
SRC_URI="mirror://gnu/datamash/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND="nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

DOCS=( NEWS README THANKS AUTHORS ChangeLog )

src_configure() {
	econf $(use_enable nls)
}
