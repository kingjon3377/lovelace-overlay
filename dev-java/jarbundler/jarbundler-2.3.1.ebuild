# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Jar Bundler Ant Task"
HOMEPAGE="http://informagen.com/JarBundler"
SRC_URI="mirror://sourceforge/${PN}/JarBundler/v${PV}/${PN}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP=">=dev-java/xerces-2.8.1"
DEPEND=">=virtual/jdk-1.4
		${COMMON_DEP}"
RDEPEND="
	>=virtual/jre-1.4
	>=dev-java/ant-core-1.7
	${COMMON_DEP}"

src_prepare() {
	rm -v *.jar || die
	java-ant_rewrite-classpath
}

EANT_GENTOO_CLASSPATH="ant-core,xerces-2"
EANT_DOC_TARGET="javadocs"

src_install() {
	java-pkg_newjar "build/${P}.jar"
	java-pkg_register-ant-task
	use doc && java-pkg_dojavadoc javadoc/
	use source && java-pkg_dosrc src/*
	dohtml dox/*
}
