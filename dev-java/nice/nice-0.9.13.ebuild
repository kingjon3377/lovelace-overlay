# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
JAVA_PKG_WANT_SOURCE=1.5
JAVA_PKG_WANT_TARGET=1.5

inherit java-pkg-2

DESCRIPTION="A programming language based on, and extending from, Java."

HOMEPAGE="https://nice.sourceforge.net"
SRC_URI="https://downloads.sourceforge.net/nice/Nice-${PV}-source.tgz"

NICE="nice-${PV}.orig"
S="${WORKDIR}/${NICE}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
RDEPEND=">=virtual/jre-1.7:*
		sys-apps/groff
		>=dev-java/javacc-3.2"
BDEPEND=">=virtual/jdk-1.7"
DEPEND="${RDEPEND}"
#RESTRICT="test"

PATCHES=( "${FILESDIR}/${P}.patch" )

src_prepare() {
	cp bin/nicec bin/nicec-gentoo
	sed -i -e 's/NICEC_JAR=.*/NICEC_JAR=$(java-config -p nice)/' bin/nicec-gentoo || die "sed failed"
	mkdir -p classes classes.old stdlib.old src.old
	cd "${S}/external"
	java-pkg_jar-from javacc
	cp -i "${FILESDIR}/jar" "${S}"/bin
	chmod +x "${S}"/bin/jar
	iconv --from-code=ISO-8859-1 --to-code=UTF-8 \
		"${S}"/regtest/coreJava/coreJava.code > "${T}/coreJava.code" && \
		mv -f "${T}/coreJava.code" "${S}"/regtest/coreJava/coreJava.code || die
	sed -i -e 's:latin1:utf-8:g' "${S}"/regtest/coreJava/Makefile || die
}

src_compile() {
	emake NICE_ANTJAR=/usr/share/ant/lib/ant.jar jar="${S}/bin/jar" \
		javac="javac -nowarn" JAVAC_FLAGS="-O" -j1 complete
	mkdir man
	./bin/nicec --man > man/nicec.1
	./bin/niceunit --man > man/niceunit.1
	groff -mandoc -Thtml man/nicec.1 > man/nicec.html
}

src_test() {
	emake test
	emake check
	emake check_lib
	emake nicetestengine
}

src_install() {
	newbin bin/nicec-gentoo nicec
	dosym nicec /usr/bin/niceunit
	dosym nicedoc /usr/bin/niceunit
	java-pkg_dojar share/java/nice.jar
	doman man/*.1
	dodoc man/nicec.html
}
