# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Console based Rhyming Dictionary"
HOMEPAGE="https://rhyme.sourceforge.net/"
SRC_URI="https://downloads.sourceforge.net/rhyme/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="sys-libs/readline:=
	sys-libs/gdbm:="
RDEPEND="${DEPEND}"

# missing files ...
RESTRICT="test"

PATCHES=( "${FILESDIR}/${P}-incompatible-pointer.patch" )

src_prepare() {
	# termcap is used by default, switch to ncurses
	sed -i Makefile \
		-e 's|-ltermcap||g' \
		-e 's|-o rhyme|$(LDFLAGS) &|g' \
		|| die "sed Makefile"
	default
}

src_compile() {
	# Disable parallel building wrt bug #125967
	emake -j1 CC="$(tc-getCC)" FLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	# author doesnt use -D for install
	dodir /usr/share/rhyme /usr/bin /usr/share/man/man1

	emake install BINPATH="${ED}"/usr/bin \
			MANPATH="${ED}"/usr/share/man/man1 \
			RHYMEPATH="${ED}"/usr/share/rhyme
}
