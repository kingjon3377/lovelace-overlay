# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="displays Wikipedia articles on the command line"
HOMEPAGE="https://github.com/chrisbra/wikipedia2text"
SRC_URI="mirror://debian/pool/main/w/${PN}/${P/-/_}.orig.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-perl/URI"

src_prepare() {
	cd "${WORKDIR}" && epatch "${FILESDIR}/wikipedia2text_0.11-2.diff"
}

src_install() {
	dobin ${PN}
	dosym ${PN} /usr/bin/wp2t
	doman "${FILESDIR}/${PN}.1"
	dosym ${PN}.1 /usr/share/man/man1/wp2t.1
	dodoc debian/{changelog,README.Debian,wikipedia2text.sgml}
}
