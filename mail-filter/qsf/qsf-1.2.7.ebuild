# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Quick Spam Filter"
HOMEPAGE="http://code.google.com/p/qsf/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="gdbm mysql sqlite"

DEPEND="gdbm? ( sys-libs/gdbm )
	mysql? ( virtual/mysql )
	sqlite? ( dev-db/sqlite:3 )"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}"
	dodoc doc/changelog doc/lsm doc/NEWS doc/PACKAGE doc/postfix-howto doc/TODO doc/quickref.txt
	newman doc/quickref.1 doc/qsf.1
	dohtml doc/index.html
	docinto extra
	dodoc extra/*
}
