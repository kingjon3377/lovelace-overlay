# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit multilib toolchain-funcs

DESCRIPTION="fast and scalable online machine learning algorithm"
HOMEPAGE="http://hunch.net/~vw/"
SRC_URI="http://github.com/JohnLangford/vowpal_wabbit/zipball/6.1 -> ${P}.zip"
REVISION=9c65131

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE="examples"

RDEPEND="dev-libs/boost"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/JohnLangford-${PN}-${REVISION}"

src_prepare() {
	sed -i -e 's:/usr/local/bin:$(DESTDIR)/usr/bin:' Makefile cluster/Makefile \
		|| die "sed failed"
}

src_compile() {
	emake COMPILER="$(tc-getCXX) ${CXXFLAGS}" \
		BOOST_LIBRARY="/usr/$(get_libdir)" all vw.1
	emake -C cluster COMPILER="$(tc-getCXX) ${CXXFLAGS}" BOOST_LIBRARY="/usr/$(get_libdir)"
}

src_test() {
	emake test
}

src_install() {
	dodir /usr/bin
	emake DESTDIR="${D}" install
	dodoc README
	doman vw.1
	if use examples; then
		insinto /usr/share/${PN}/examples
		doins -r test/*
	fi
}
