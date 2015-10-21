# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="An interactive line selection tool for ASCII files"
HOMEPAGE="http://www.ossp.org/pkg/tool/iselect/"
SRC_URI="ftp://ftp.ossp.org/pkg/tool/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="sys-libs/ncurses:0"
RDEPEND="${DEPEND}"

src_install() {
	dobin iselect
	doman iselect.1
	dodoc ChangeLog *.txt PORTING README VERSIONS
	docinto examples
	dodoc example/README
	for a in $(ls examples | grep -v README);do
		docinto examples/${a}
		dodoc example/${a}/*
	done
}
