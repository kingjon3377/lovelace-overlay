# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit wrapper unpacker desktop

DESCRIPTION="A simple to use EPUB and MobiPocket ebook creator"
HOMEPAGE="http://www.juliansmart.com/ecub"
SRC_URI="x86? ( http://www.anthemion.co.uk/${PN}/${PN}_${PV}-1_i386.deb )
amd64? ( http://www.anthemion.co.uk/ecub/${PN}_${PV}-1_amd64.deb )"

LICENSE="eCub"
SLOT="0"
KEYWORDS="amd64 x86"

S="${WORKDIR}"

PATCHES=(
	"${FILESDIR}/desktop.patch"
)

src_install() {
	dodir /usr/bin
	dodir /usr/share
	cd "${WORKDIR}"
	dodoc usr/share/ecub/readme.txt
	rm usr/share/ecub/readme.txt
	# TODO: Use doins -r instead of cp
	cp -R "usr/share/ecub" "${D}/usr/share/" || die
	make_wrapper ${PN} ../share/${PN}/${PN}
	# TODO: Exclude icon and .desktop from being installed to /usr/share/ecub, or make these symlinks instead
	newicon usr/share/ecub/appicons/ecub48x48.png ${PN}.png
	domenu usr/share/ecub/ecub.desktop
}
