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

COMMON_DEPEND=""
#COMMON_DEPEND="dev-java/jcifs
#	dev-java/j2ssh
#	dev-java/yanfs"
DEPEND="${COMMON_DEPEND}
	>=virtual/jdk-1.5"
RDEPEND="${COMMON_DEPEND}
	>=virtual/jre-1.5"

S="${WORKDIR}/${PN}"

src_install() {
	java-pkg_dojar build/jars/jftp.jar
	newbin "${FILESDIR}/jftp.run" ${PN}
	insinto /usr/share/applications
	doins "${FILESDIR}/jftp.desktop"
	insinto /usr/share/pixmaps
	doins "${FILESDIR}/jftp.xpm"
	dodoc CHANGELOG readme
}
