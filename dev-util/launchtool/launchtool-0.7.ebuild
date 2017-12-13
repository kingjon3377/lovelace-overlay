# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit autotools eutils

DESCRIPTION="Runs a user-supplied command and can supervise its execution in many ways"
HOMEPAGE="http://people.debian.org/~enrico/launchtool.html"
SRC_URI="http://people.debian.org/~enrico/woody/source/${PN}_${PV}-1.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
IUSE=""

RDEPEND="dev-libs/popt"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${PV}-gcc4.4.patch
	"${FILESDIR}"/${PV}-Wall.patch
	"${FILESDIR}"/${PV}-pid.patch
)

src_prepare() {
	default
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README TODO
	doman ${PN}.1
}
