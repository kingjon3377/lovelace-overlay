# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="A shell script to make Mac .app bundles compatible with various Java versions"
HOMEPAGE="https://github.com/tofi86/universalJavaApplicationStub"
SRC_URI="https://github.com/tofi86/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

RDEPEND=""
DEPEND=""

src_install() {
	insinto /usr/share/${PN}
	doins src/${PN}
	dodoc CHANGELOG.md README.md
}
