# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="simple text-based todo manager"
HOMEPAGE="http://w2do.blackened.cz/"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3 FDL-1.3+"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"

src_install() {
	emake prefix="${D}"/usr install
	dodoc AUTHORS TODO
}
