# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# TODO: Should probably use python-r1 related eclass

DESCRIPTION="is a game of dexterity where you match stones together"
HOMEPAGE="http://krank.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/${P}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="dev-python/pygame
	dev-python/pyyaml"
RDEPEND=""

src_prepare() {
	sed -i 's:KRANKPATH=`dirname $0`:KRANKPATH=/usr/share/krank:' ${PN} \
		|| die "sed failed"
}

src_install() {
	insinto /usr/share/${PN}
	doins -r art fonts levels sounds src
	dobin ${PN}
	dodoc -r html CHANGELOG.txt README
}
