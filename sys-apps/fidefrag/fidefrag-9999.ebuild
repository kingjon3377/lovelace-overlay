# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit bzr

DESCRIPTION="Filesystem-independent defragmenter"
HOMEPAGE="https://launchpad.net/fidefrag"
SRC_URI=""
EBZR_REPO_URI=lp:fidefrag

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-lang/python"
RDEPEND="${DEPEND}"

src_install() {
	cd src
	insinto /usr/$(get_libdir)/${PN}
	doins *py
	dosym ../$(get_libdir)/${PN}/${PN}.py /usr/sbin/${PN}
	dodoc README.txt
}
