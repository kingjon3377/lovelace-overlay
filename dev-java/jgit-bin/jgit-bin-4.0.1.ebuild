# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

MY_PN=jgit

MY_PV=${PV}.201506240215-r

DESCRIPTION="Java Git implementation"
HOMEPAGE="http://eclipse.org/jgit"
SRC_URI="https://repo.eclipse.org/content/groups/releases//org/eclipse/${MY_PN}/org.eclipse.${MY_PN}/${MY_PV}/org.eclipse.${MY_PN}-${MY_PV}.jar"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

COMMON_DEP=""

RDEPEND=">=virtual/jre-1.4
	dev-java/slf4j-api
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.4
	${COMMON_DEP}"

EANT_BUILD_TARGET=""
EANT_DOC_TARGET=""

S="${WORKDIR}"

src_install() {
	java-pkg_register-dependency slf4j-api
	java-pkg_newjar "${DISTDIR}/org.eclipse.${MY_PN}-${MY_PV}.jar" "${MY_PN}.jar"
}
