# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MY_P="${P/_/-}"
OPENGL_REQUIRED="always"
inherit kde4-base

DESCRIPTION="LEGO(r) CAD"
HOMEPAGE="http://konstruktor.influx.kr/"
SRC_URI="http://konstruktor.influx.kr/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND="dev-db/sqlite:3"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

pkg_postinst() {
	einfo "You still need to obtain ldraw data files."
	einfo "Because they are not distributable you need to download them from:"
	einfo "  http://www.ldraw.org/Downloads-req-viewdownload-cid-1.html"
}
