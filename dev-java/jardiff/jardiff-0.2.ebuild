# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
JAVA_PKG_IUSE="doc source"
inherit java-pkg-2 java-ant-2

DESCRIPTION="tool to visualise API differences between two JAR files"
HOMEPAGE="http://www.osjava.org/jardiff/"
SRC_URI="mirror://debian/pool/main/j/${PN}/${P/-/_}.orig.tar.gz
	mirror://debian/pool/main/j/${PN}/${P/-/_}-3.debian.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"

IUSE=""

COMMON_DEP="dev-java/asm:3
	dev-java/commons-cli"

RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	${COMMON_DEP}"

EANT_BUILD_TARGET=""
EANT_DOC_TARGET=""

EANT_EXTRA_ARGS="-Dnoget=true -Dfinal.name=${PN}"

src_prepare() {
	epatch "${WORKDIR}/debian/patches"/*diff
	mkdir -p target/lib
	cd target/lib
	java-pkg_jar-from asm-3
	java-pkg_jar-from commons-cli-1
	java-pkg_jar-from --build-only ant-core
	java-pkg_jar-from --build-only ant-junit
}

src_install() {
	java-pkg_dojar target/"${PN}.jar"
	use doc && java-pkg_dojavadoc build/javadoc
	use source && java-pkg_dosrc src
	dobin "${FILESDIR}/${PN}"
	doman "${WORKDIR}/debian/jardiff.1"
	dodoc "${WORKDIR}/debian/changelog" "${WORKDIR}/debian/copyright"
}
