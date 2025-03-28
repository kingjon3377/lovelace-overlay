# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2

DESCRIPTION="Jar Bundler Ant Task"
HOMEPAGE="https://github.com/UltraMixer/JarBundler"
SRC_URI="https://github.com/UltraMixer/Jarbundler/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/JarBundler-${PV}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

COMMON_DEP="
	>=dev-java/ant-1.7:0
	>=dev-java/xerces-2.8.1:2"
DEPEND="${COMMON_DEP}"
BDEPEND=">=virtual/jdk-1.7"
RDEPEND="${COMMON_DEP}
	>=virtual/jre-1.7"

src_prepare() {
	find -name '*.jar' -delete || die
	sed -i -e 's@srcdir="src"@srcdir="core/src"@' build.xml || die
	mv -i examples/build.xml{,.old} || die
	iconv -f iso-8859-1 -t utf-8 examples/build.xml.old > examples/build.xml || die
	rm -f examples/build.xml.old || die
	default
}

JAVA_ANT_REWRITE_CLASSPATH="yes"

EANT_GENTOO_CLASSPATH="ant,xerces-2"
EANT_DOC_TARGET="javadocs"
EANT_EXTRA_ARGS="-Dversion=${PV} -Dant.jar=/usr/share/ant/lib/ant.jar"

src_install() {
	java-pkg_newjar "build/${P}.jar"
	java-pkg_register-ant-task

	use doc && java-pkg_dojavadoc javadoc/
	use source && java-pkg_dosrc core/src/*
}
