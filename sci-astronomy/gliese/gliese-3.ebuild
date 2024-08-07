# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="stellar data set from the Third Catalogue of Nearby Stars"
HOMEPAGE="http://starplot.org/datafiles.html"
# TODO: Plainly PV should be 0.95
SRC_URI="http://starplot.org/data/${P/-/}-0.95.tar.gz"

S="${WORKDIR}/${P/-/}-0.95"
LICENSE="stars GPL-2"
SLOT="0"
KEYWORDS="amd64"

DEPEND="sci-astronomy/starplot"
RDEPEND="${DEPEND}"

src_install() {
	dodoc Changelog README
	dodir /usr/$(get_libdir)/stardata
	starpkg --dataset . --dest "${D}/usr/$(get_libdir)/stardata" || die "install failed"
}
