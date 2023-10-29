# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="perpetual Jewish calendar"
HOMEPAGE="http://hebcal.github.io/ https://github.com/hebcal/hebcal"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="${DEPEND}"

DOCS=( AUTHORS NEWS.md README.md )

src_prepare() {
	default
	eautoreconf
}

src_test() {
	emake check
}
