# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

MY_PV=${PV}.201506240215-r

DESCRIPTION="Java Git implementation"
HOMEPAGE="http://eclipse.org/jgit"
SRC_URI="https://github.com/eclipse/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${PN}-${MY_PV}"

IUSE=""

COMMON_DEP="dev-java/slf4j-api:0
	dev-java/junit:4
	dev-java/osgi-core-api:0
	dev-java/ant-core:0
	dev-java/commons-compress:0
	dev-java/javaewah:0
	dev-java/commons-httpclient:3
	dev-java/servletapi:2.4
	www-servers/jetty:6[client]
	dev-java/jsch:0"

RDEPEND=">=virtual/jre-1.7
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.7
	${COMMON_DEP}"

EANT_BUILD_TARGET=""
EANT_DOC_TARGET=""

JAVA_GENTOO_CLASSPATH="slf4j-api jsch junit-4 osgi-core-api ant-core commons-compress commons-httpclient-3 javaewah servletapi-2.4 jetty-6"

#src_install() {
#  java-pkg_dojar "${PN}.jar"
#  use doc && java-pkg_dojavadoc build/javadoc
#  use source && java-pkg_dosrc src
#}
