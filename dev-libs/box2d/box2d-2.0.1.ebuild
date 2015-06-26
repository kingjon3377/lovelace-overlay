# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MY_PN=Box2D

inherit eutils

IUSE=""

DESCRIPTION="Box2D is an open source physics engine written primarily for games."
HOMEPAGE="http://www.box2d.org"
SRC_URI="http://box2d.googlecode.com/files/${MY_PN}_v${PV}.zip"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="media-libs/freeglut"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}"/${MY_PN}_v${PV}/${MY_PN}/Source

src_prepare(){
	edos2unix Common/b2BlockAllocator.cpp Common/b2Math.h
	epatch "${FILESDIR}"/${P}-gcc4.patch
	sed -i -e "s:../Source/::g" -i ../Include/Box2D.h || die "sed failed"
}

src_compile() {
	emake
}

src_install() {
	dodoc ../Readme.txt

	dolib.a Gen/float/lib${PN}.a

	insinto /usr/include/${MY_PN}/
	doins ../Include/${MY_PN}.h
	insinto /usr/include/${MY_PN}/Collision/
	doins Collision/*.h
	insinto /usr/include/${MY_PN}/Collision/Shapes/
	doins Collision/Shapes/*.h
	insinto /usr/include/${MY_PN}/Common/
	doins Common/*.h
	insinto /usr/include/${MY_PN}/Dynamics/
	doins Dynamics/*.h
	insinto /usr/include/${MY_PN}/Dynamics/Contacts/
	doins Dynamics/Contacts/*.h
	insinto /usr/include/${MY_PN}/Dynamics/Joints/
	doins Dynamics/Joints/*.h
}
