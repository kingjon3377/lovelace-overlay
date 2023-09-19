# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Jar Bundler Ant Task"
HOMEPAGE="https://github.com/tofi86/Jarbundler"
SRC_URI="https://github.com/tofi86/Jarbundler/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP="
	>=dev-java/ant-core-1.7:0
	>=dev-java/xerces-2.8.1:2"
DEPEND="${COMMON_DEP}"
BDEPEND=">=virtual/jdk-1.7"
RDEPEND="${COMMON_DEP}
	>=virtual/jre-1.7"

src_prepare() {
	find -name '*.jar' -delete || die
	default
}

JAVA_ANT_REWRITE_CLASSPATH="yes"

EANT_GENTOO_CLASSPATH="ant-core,xerces-2"
EANT_DOC_TARGET="javadocs"

src_install() {
	java-pkg_newjar "build/${P}.jar"
	java-pkg_register-ant-task

	use doc && java-pkg_dojavadoc javadoc/
	use source && java-pkg_dosrc src/*
}
