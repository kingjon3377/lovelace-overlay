# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="displays Wikipedia articles on the command line"
HOMEPAGE="https://github.com/chrisbra/wikipedia2text"
SRC_URI="https://github.com/chrisbra/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-perl/URI"

src_install() {
	dobin ${PN}
	dosym ${PN} /usr/bin/wp2t
	doman "${FILESDIR}/${PN}.1"
	dosym ${PN}.1 /usr/share/man/man1/wp2t.1
	dodoc "${FILESDIR}/README.Debian" "${FILESDIR}/${PN}.sgml"
}
