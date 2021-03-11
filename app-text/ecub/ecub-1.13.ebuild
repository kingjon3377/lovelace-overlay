# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit wrapper unpacker

DESCRIPTION="A simple to use EPUB and MobiPocket ebook creator"
HOMEPAGE="http://www.juliansmart.com/ecub"
SRC_URI="x86? ( http://www.anthemion.co.uk/${PN}/${PN}_${PV}-1_i386.deb )"
# amd64? ( http://www.anthemion.co.uk/ecub/${PN}_${PV}-1_amd64.deb )"

LICENSE="eCub"
SLOT="0"
KEYWORDS="~x86" # no amd64 DEB or TGZ for this version
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"

PATCHES=(
	"${FILESDIR}/desktop.patch"
)

src_install() {
	dodir /usr/bin /usr/share/applications /usr/share/pixmaps
	cd "${WORKDIR}"
	dodoc usr/share/ecub/readme.txt
	rm usr/share/ecub/readme.txt
	insinto /usr/share
	doins -r usr/share/${PN}
	make_wrapper ${PN} ../share/${PN}/${PN}
	insinto /usr/share/pixmaps
	# TODO: Exclude icon and .desktop from being installed to /usr/share/ecub, or make these symlinks instead
	newins usr/share/ecub/appicons/ecub48x48.png ecub.png
	insinto /usr/share/applications
	doins usr/share/ecub/ecub.desktop
}
