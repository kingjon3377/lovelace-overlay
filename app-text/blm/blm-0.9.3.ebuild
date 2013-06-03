# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Boolean line manipulator utility program for set operations"
HOMEPAGE="http://packages.debian.org/sid/blm"
SRC_URI="mirror://debian/pool/main/b/blm/${P/-/_}.orig.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dodoc AUTHORS ChangeLog NEWS README
	emake DESTDIR="${D}" install install-man
}
