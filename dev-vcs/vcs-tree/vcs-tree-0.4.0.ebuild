# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Version Control System Tree Walker"
HOMEPAGE="http://files.b9.com/vcs-tree/"
SRC_URI="http://files.b9.com/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-lisp/sbcl"
RDEPEND="${DEPEND}"

RESTRICT="strip"

src_prepare() {
	sed -i -e 's:HOME=/:HOME=$(HOME):' Makefile || die "sed failed"
	sed -i -e "s:^_vcs-tree:/usr/libexec/${PN}/_vcs-tree:" ${PN} || die
}

src_compile() {
	HOME="${T}" emake _vcs-tree
}

src_install() {
	exeinto /usr/libexec/${PN}
	newexe _vcs-tree ${PN}
	dobin ${PN}
	doman ${PN}.1
}
