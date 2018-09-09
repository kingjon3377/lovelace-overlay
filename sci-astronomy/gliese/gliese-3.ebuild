# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib

DESCRIPTION="stellar data set from the Third Catalogue of Nearby Stars"
HOMEPAGE="http://starplot.org/datafiles.html"
SRC_URI="http://starplot.org/data/${P/-/}-0.95.tar.gz"

LICENSE="stars GPL-2"
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
