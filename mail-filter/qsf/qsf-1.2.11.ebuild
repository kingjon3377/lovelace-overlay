# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Quick Spam Filter"
HOMEPAGE="http://www.ivarch.com/programs/qsf/"
SRC_URI="http://www.ivarch.com/programs/sources/${P}.tar.bz2"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gdbm mysql sqlite"

DEPEND="gdbm? ( sys-libs/gdbm )
	mysql? ( virtual/mysql )
	sqlite? ( dev-db/sqlite:0 )"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install
	dodoc doc/lsm doc/NEWS doc/PACKAGE doc/postfix-howto doc/TODO doc/quickref.txt
	dohtml doc/index.html
	docinto extra
	dodoc extra/*
}
