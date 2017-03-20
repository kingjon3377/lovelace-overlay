# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="A filesharing utility and upload/download manager for freenet"
HOMEPAGE="http://wiki.freenetproject.org/Thaw/"
SRC_URI="http://dev.gentooexperimental.org/~tommy/${P}.tar.bz2"
LICENSE="GPL-3"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

CDEPEND="dev-java/jmdns:0
	dev-db/hsqldb:0
	dev-java/bcprov:1.54"
RDEPEND="${CDEPEND}
	>=virtual/jre-1.4
	net-p2p/freenet"
DEPEND="${CDEPEND}
	>=virtual/jdk-1.4
	dev-java/ant
	dev-java/jmdns
	dev-db/hsqldb"
S="${WORKDIR}/thaw"

PATCHES=(
	"${FILESDIR}/thaw-0.8.4-jmdns_abstract.patch"
	"${FILESDIR}/thaw-0.8.4-jmdns_uncaught_exception.patch"
)

src_prepare() {
	default
	cd "${S}"/lib
	java-pkg_jar-from jmdns
	java-pkg_jar-from hsqldb
	java-pkg_jar-from bcprov-1.54 bcprov.jar BouncyCastle.jar
}

src_install() {
	# FIXME: Install JAR and directory for user data separately
	java-pkg_jarinto /opt/${PN}
	java-pkg_dojar bin/Thaw.jar
	java-pkg_dolauncher "${PN}" --jar "/opt/${PN}/Thaw.jar" --pwd "/opt/${PN}"
	dosym "$(java-pkg_getjar jmdns jmdns.jar)" /opt/${PN}/jmdns.jar
	dosym "$(java-pkg_getjar hsqldb hsqldb.jar)" /opt/${PN}/hsqldb.jar
	dosym "$(java-pkg_getjar bcprov-1.54 bcprov.jar)" /opt/${PN}/BouncyCastle.jar
}

pkg_postinst() {
	chmod  o+w /opt/thaw
}

pkg_postrm() {
	elog "If you dont want to use thaw any more and don't want to keep your"
	elog "identities/other stuff, remember to do 'rm -rf /opt/thaw' do remove everything"
}
