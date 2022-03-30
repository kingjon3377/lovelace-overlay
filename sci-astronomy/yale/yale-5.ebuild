# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="stellar data set from the Yale Bright Star Catalog"
HOMEPAGE="http://starplot.org/datafiles.html"
# TODO: Clearly PV should be 0.95 ...
SRC_URI="http://starplot.org/data/${P/-/}-0.95.tar.gz"

LICENSE="stars"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="sci-astronomy/starplot"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P/-/}-0.95"

src_install() {
	dodoc Changelog README
	dodir /usr/$(get_libdir)/stardata
	starpkg --dataset . --dest "${D}/usr/$(get_libdir)/stardata" || die "install failed"
}
