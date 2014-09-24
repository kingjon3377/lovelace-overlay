# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs

DESCRIPTION="LaTeX to XML translator"
HOMEPAGE="http://www-sop.inria.fr/marelle/tralics/"
SRC_URI="ftp://ftp-sop.inria.fr/marelle/${PN}/src/${PN}-src-${PV}.tar.gz"

LICENSE="CeCILL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( app-text/texlive-core )" # bibtex

src_prepare() {
	sed -i -e 's/^CPPFLAGS/#&/' src/Makefile || die
}

src_compile() {
	emake -C src CC=$(tc-getCXX) CCC=$(tc-getCXX) CXX=$(tc-getCXX) \
		CPPFLAGS="${CFLAGS} -DTRALICSDIR=\\\"/usr/share/${PN}\\\" -DCONFDIR=\\\"/usr/share/${PN}\\\""
}

src_test() {
	cd Test
	./alltests || die "Tests failed"
}

src_install() {
	dobin src/${PN}
	# Following Debian, we put all "configuration" files in /usr/share.
	# TODO: move what *should* be to /etc to there, if anything should.
	insinto /usr/share/${PN}
	doins confdir/*
	rm "${D}/usr/share/${PN}/COPYING"
	doman "${FILESDIR}/${PN}.1"
	dodoc README
}
