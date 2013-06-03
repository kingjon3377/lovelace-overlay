# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="desk calculator language"
HOMEPAGE="http://nickle.org"
SRC_URI="http://nickle.org/release/${P}.tar.gz"

LICENSE="BSD-1"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README* TODO
}
