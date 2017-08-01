# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit multilib toolchain-funcs vcs-snapshot

DESCRIPTION="fast and scalable online machine learning algorithm"
HOMEPAGE="http://hunch.net/~vw/"
SRC_URI="http://github.com/JohnLangford/vowpal_wabbit/tarball/${PV} -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

RDEPEND="dev-libs/boost"
DEPEND="${RDEPEND}"

# Tests fail in 7.7, and getting the upstream commits that fix those tests to
# apply gets far too complicated far too quickly.
RESTRICT="test"

src_prepare() {
	sed -i -e 's:/usr/local/bin:$(DESTDIR)/usr/bin:' Makefile cluster/Makefile \
		|| die "sed failed"
}

src_compile() {
	emake CXX=$(tc-getCXX) "CFLAGS=${CXXFLAGS}"
		BOOST_LIBRARY="/usr/$(get_libdir)" all
	emake vw.1
	test -f vw.1 || die
	emake -C cluster CXX=$(tc-getCXX) CFLAGS="${CXXFLAGS}" BOOST_LIBRARY="/usr/$(get_libdir)"
}

src_test() {
	emake test
}

src_install() {
	dodir /usr/bin
	emake DESTDIR="${D}" install
	dodoc README.md
	doman vw.1
	use examples && \
		insinto /usr/share/${PN}/examples && \
		doins -r test/*
}
