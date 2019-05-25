# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/chipx86/gtkparasite"

inherit git-r3 autotools

DESCRIPTION="GTK+ debugging and development tool"
HOMEPAGE="https://chipx86.github.io/gtkparasite/"

LICENSE="BSD-1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

PATCHES=(  "${FILESDIR}/gtkparasite_0+git20090907-1.diff" )

src_prepare() {
	# bootstrap build system
	eautoreconf
	default
}

DOCS=( debian/README.Debian )
