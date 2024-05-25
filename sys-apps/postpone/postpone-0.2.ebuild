# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="schedules commands to be executed later"
HOMEPAGE="https://www.df7cb.de/projects/postpone/"
#SRC_URI="https://www.df7cb.de/projects/${PN}/packages/${P/-/_}.tar.gz"
SRC_URI="mirror://debian/pool/main/p/${PN}/${P/-/_}.tar.gz"

S="${WORKDIR}/trunk"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="${DEPEND}"

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CLFAGS} ${LDFLAGS}" postpone
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
	dodoc README
}
