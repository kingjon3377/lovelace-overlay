# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="C source code analyzer"
HOMEPAGE="http://students.ceid.upatras.gr/~sxanth/ncc/"
SRC_URI="http://students.ceid.upatras.gr/~sxanth/${PN}/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

#PATCHES=( "${FILESDIR}"/${P}-flags.patch )

src_compile() {
	emake \
			-C nccnav \
			CC="$(tc-getCXX)" \
			CFLAGS="${CFLAGS} -c" \
			LCFLAGS="${CFLAGS} ${LDFLAGS}" \
			-j1

	emake \
			CC="$(tc-getCXX)" \
			CFLAGS="${CFLAGS} -c" \
			LCFLAGS="${CFLAGS} ${LDFLAGS}"
}

src_install() {
	dodir /usr/bin /usr/include /usr/share/man/man1
	emake DESTDIR="${D}/usr" install

	dodoc doc/CHANGES doc/dbstree.dvi doc/dbstree.tex doc/hacking.* doc/KEYS.txt \
		README doc/NCC doc/TROUBLES

	insinto /usr/share/doc/${PF}/
	doins doc/*.c || die
	newdoc nccnav/README NCCNAV || die

	newbin scripts/gengraph.py nccgengraph || die
	newman scripts/gengraph.py.1 nccgengraph.1 || die
}
