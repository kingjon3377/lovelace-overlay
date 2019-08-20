# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV=${PV/_p/-0ubuntu1~ppa}

DESCRIPTION="Latin dictionary"
HOMEPAGE="https://launchpad.net/~chameleondave/+archive/ppa"
SRC_URI="https://ppa.launchpad.net/chameleondave/ppa/ubuntu/pool/main/g/${PN}/${PN}_${MY_PV}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="dev-lang/tcl
	dev-lang/tk"
DEPEND=""

S="${WORKDIR}/${PN}-0.1"

src_install() {
	insinto /usr/share/${PN}
	doins ${PN}/*tcl ${PN}/*GEN ${PN}/INFLECTS
	fperms +x /usr/share/${PN}/${PN}.tcl
	dosym ../share/${PN}/${PN}.tcl /usr/bin/${PN}
	dodoc ${PN}/documentation_from_website.html AUTHORS README
}
