# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
EGIT_REPO_URI="git://svcs.cs.pdx.edu/git/simhash.git"

inherit git-r3 toolchain-funcs

DESCRIPTION="generate similarity hashes to find nearly duplicate files"
HOMEPAGE="http://wiki.cs.pdx.edu/forge/simhash.html"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}"
}

src_install() {
	dobin ${PN}
	newman ${PN}.man ${PN}.1
}
