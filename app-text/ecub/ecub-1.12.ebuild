# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils unpacker

DESCRIPTION="A simple to use EPUB and MobiPocket ebook creator"
HOMEPAGE="http://www.juliansmart.com/ecub"
SRC_URI="x86? ( http://www.anthemion.co.uk/${PN}/${PN}_${PV}-1_i386.deb )
amd64? ( http://www.anthemion.co.uk/ecub/${PN}_${PV}-1_amd64.deb )"

LICENSE="eCub"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"

PATCHES=(
	"${FILESDIR}/desktop.patch"
)

src_install() {
	dodir /usr/bin
	dodir /usr/share
	dodir /usr/share/applications
	dodir /usr/share/pixmaps
	cd "${WORKDIR}"
	dodoc usr/share/ecub/readme.txt
	rm usr/share/ecub/readme.txt
	cp -R "usr/share/ecub" "${D}usr/share/" || die
	make_wrapper ${PN} ../share/${PN}/${PN}
	insinto /usr/share/pixmaps
	newins usr/share/ecub/appicons/ecub48x48.png ecub.png
	insinto /usr/share/applications
	doins usr/share/ecub/ecub.desktop
}
