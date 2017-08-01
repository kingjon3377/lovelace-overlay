# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

JAVA_SRC_DIR=src
JAVA_PKG_IUSE="doc source"

inherit games java-pkg-2 java-pkg-simple

DESCRIPTION="Random name generator"
HOMEPAGE="http://lightless.org/namespawner"
SRC_URI="http://lightless.org/files/NameSpawner.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

COMMON_DEPEND=""
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEPEND}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEPEND}"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	unpack ./source.tar.gz
}

src_compile() {
	mkdir -p target/classes/META-INF
	mv -i manifest target/classes/META-INF/MANIFEST.MF
	java-pkg-simple_src_compile
}

src_install() {
	java-pkg-simple_src_install
	dodir "${GAMES_DATADIR}/${PN}/themes"
	insinto "${GAMES_DATADIR}/${PN}/themes"
	doins themes/*
	dodir "${GAMES_DATADIR}/${PN}/examples"
	insinto "${GAMES_DATADIR}/${PN}/examples"
	doins examples/*
	dodoc README.txt
	java-pkg_dolauncher ${PN} -into "${GAMES_PREFIX}" \
		--pkg_args "${GAMES_DATADIR}/${PN}/themes"
	java-pkg_dolauncher ${PN}-cli -into "${GAMES_PREFIX}" \
		--main org.lightless.namespawner.NameSpawner
}
