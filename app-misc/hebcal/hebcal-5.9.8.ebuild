# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="perpetual Jewish calendar"
HOMEPAGE="http://hebcal.github.io/ https://github.com/hebcal/hebcal"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

# github.com/dustin/go-humanize: MIT
# github.com/hebcal/gematriya: BSD-2
# github.com/hebcal/greg: GPL-2.0
# github.com/hebcal/hdate: GPL-2.0
# github.com/hebcal/hebcal: GPL-2.0
# github.com/hebcal/hebcal-go: GPL-2.0
# github.com/nathan-osman/go-sunrise: MIT
# github.com/pborman/getopt/v2: BSD-3
LICENSE="GPL-2 MIT BSD-2 BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="${DEPEND}"

DOCS=( AUTHORS NEWS.md README.md )

src_prepare() {
	sed -i -e 's@install -s@install@' Makefile || die
	default
}

src_compile() {
	emake all "PREFIX=${EPREFIX}/usr"
}

src_test() {
	emake check
}

src_install() {
	emake install PREFIX="${ED}/usr"
}
