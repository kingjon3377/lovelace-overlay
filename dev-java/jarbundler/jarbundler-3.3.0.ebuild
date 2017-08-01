# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Jar Bundler Ant Task"
HOMEPAGE="https://github.com/UltraMixer/JarBundler"
SRC_URI="https://github.com/UltraMixer/Jarbundler/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP="
	>=dev-java/ant-core-1.7:0
	>=dev-java/xerces-2.8.1:2"
DEPEND="${COMMON_DEP}
	>=virtual/jdk-1.6"
RDEPEND="${COMMON_DEP}
	>=virtual/jre-1.6"

java_prepare() {
	find -name '*.jar' -delete || die
	sed -i -e 's@srcdir="src"@srcdir="core/src"@' build.xml || die
}

S="${WORKDIR}/JarBundler-${PV}"

JAVA_ANT_REWRITE_CLASSPATH="yes"

EANT_GENTOO_CLASSPATH="ant-core,xerces-2"
EANT_DOC_TARGET="javadocs"
EANT_EXTRA_ARGS="-Dversion=${PV} -Dant.jar=/usr/share/ant/lib/ant.jar"

src_install() {
	java-pkg_newjar "build/${P}.jar"
	java-pkg_register-ant-task

	use doc && java-pkg_dojavadoc javadoc/
	use source && java-pkg_dosrc core/src/*
}
