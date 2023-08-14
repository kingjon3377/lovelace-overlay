# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop java-pkg-2 java-pkg-simple

MY_PN=OpticalRayTracer
DESCRIPTION="Virtual lens design workshop"
HOMEPAGE="https://arachnoid.com/OpticalRayTracer"
SRC_URI="https://arachnoid.com/${MY_PN}/resources/${MY_PN}_source.tar.bz2 -> ${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc source"

COMMON_DEPEND=""

DEPEND="${COMMON_DEPEND}
	>=virtual/jdk-1.7"
RDEPEND="${COMMON_DEPEND}
	>=virtual/jre-1.7"

S="${WORKDIR}"

src_install() {
	java-pkg-simple_src_install
	doman "${FILESDIR}/${PN}.1"
	java-pkg_dolauncher
	doicon "${WORKDIR}/${MY_PN}/src/${PN}/icons/${MY_PN}.png"
	make_desktop_entry /usr/bin/${PN} ${MY_PN} ${MY_PN} \
		Applications/Science/Physics
}
