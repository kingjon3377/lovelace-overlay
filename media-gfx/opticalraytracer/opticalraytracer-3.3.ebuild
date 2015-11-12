# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Virtual lens design workshop"
HOMEPAGE="http://www.arachnoid.com/OpticalRayTracer"
SRC_URI="http://www.arachnoid.com/OpticalRayTracer/OpticalRayTracer_source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc source"

COMMON_DEPEND=""

DEPEND="${COMMON_DEPEND}
	>=virtual/jdk-1.5"
RDEPEND="${COMMON_DEPEND}
	>=virtual/jre-1.5"

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}/disable-ant-propertyfile.patch"
	cp "${FILESDIR}/build.xml" .
}

src_install() {
	java-pkg_dojar dist/OpticalRayTracer.jar
	use doc && java-pkg_dojavadoc javadocs
	use source && java-pkg_dosrc src/
	doman "${FILESDIR}/${PN}.1"
	java-pkg_dolauncher
	doicon build/classes/${PN}/icons/OpticalRayTracer.png
	make_desktop_entry /usr/bin/${PN} OpticalRayTracer OpticalRayTracer \
		Applications/Science/Physics
}
