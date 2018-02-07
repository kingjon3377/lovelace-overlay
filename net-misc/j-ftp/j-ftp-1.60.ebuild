# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit java-pkg-2 java-ant-2

DESCRIPTION="Java GUI client for FTP, SMB, SFTP and NFS"
HOMEPAGE="http://j-ftp.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/jftp/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

EANT_BUILD_TARGET="jars"

COMMON_DEPEND="dev-java/kunststoff:0
	dev-java/commons-codec:0
	dev-java/commons-logging:0
	dev-java/j2ssh:0
	dev-java/jcifs:1.1
	dev-java/jlayer:0
	dev-java/jsch:0
	dev-java/log4j:0
	dev-java/yanfs:0
	dev-java/swt:4.2
	dev-java/miglayout:0
	dev-java/commons-httpclient:3"
DEPEND="${COMMON_DEPEND}
	>=virtual/jdk-1.6"
RDEPEND="${COMMON_DEPEND}
	>=virtual/jre-1.6"

S="${WORKDIR}/${PN}"

src_prepare() {
	eant clean
	rm -r lib/*
	for lib in kunststoff commons-codec commons-logging j2ssh jcifs-1.1 \
			jlayer jsch log4j miglayout yanfs swt-4.2 commons-httpclient-3;do
		java-pkg_jar-from --into lib "${lib}"
	done
	iconv --from-code=ISO-8859-1 --to-code=UTF-8 \
		src/java/net/sf/jftp/gui/base/dir/MaterializedTableModel.java > \
		src/java/net/sf/jftp/gui/base/dir/MaterializedTableModel.java.fixed || die
	mv -f src/java/net/sf/jftp/gui/base/dir/MaterializedTableModel.java.fixed \
		src/java/net/sf/jftp/gui/base/dir/MaterializedTableModel.java || die
	epatch "${FILESDIR}"/*.patch
	rm src/java/net/sf/jftp/net/wrappers/WebdavConnection.java \
		src/java/net/sf/jftp/gui/hostchooser/WebdavHostChooser.java || die
}

src_install() {
	java-pkg_dojar build/jars/jftp.jar
	newbin "${FILESDIR}/jftp.run" ${PN}
	insinto /usr/share/applications
	doins "${FILESDIR}/jftp.desktop"
	insinto /usr/share/pixmaps
	doins "${FILESDIR}/jftp.xpm"
	dodoc CHANGELOG readme
}
