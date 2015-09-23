# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DISTUTILS_OPTIONAL=true

PYTHON_COMPAT=( python2_7 )
inherit games eutils distutils-r1 toolchain-funcs

DESCRIPTION="conversation simulator that can learn as you talk to it"
HOMEPAGE="http://megahal.alioth.debian.org/"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${P}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="+perl +python +tcl"

DEPEND="perl? ( dev-lang/perl )
	python? ( ${PYTHON_DEPS} )
	tcl? ( dev-lang/tcl:= )"
RDEPEND="${DEPEND}
	perl? ( dev-lang/perl:= )"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

src_prepare() {
	epatch "${FILESDIR}"/megahal_9.1.1a-9.diff
	mkdir -p debian
	if use perl;then
		cp "${FILESDIR}/"*.pl . || die
		cp "${FILESDIR}/"*.pm debian/ || die
	fi
	if use python; then
		cp "${FILESDIR}/"*.py . || die
	fi
	cp "${FILESDIR}/megahal-personal" debian/ || die
	sed -i -e "s@/lib/@/$(get_libdir)/g" debian/megahal-personal
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}"
	use perl && emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" perlmodule
	use python && distutils-r1_src_compile
	ewarn "I couldn't figure out how to build the Tcl extension separately"
}

src_install() {
	dogamesbin megahal debian/megahal-personal
	insinto /usr/$(get_libdir)/megahal
	doins megahal.{aux,ban,grt,swp,trn}
	use tcl && doins libmh_tcl.so
	use python && distutils-r1_src_install
	use perl && emake DESTDIR="${D}" perlmodule-install
	newman docs/megahal.1 megahal.6
	newman docs/megahal.1 megahal-personal.6
	doman docs/megahal_interfaces.3
	dodoc ChangeLog docs/paper.txt docs/README.TXT "${FILESDIR}/README.debian"
	make_desktop_entry /usr/bin/megahal "MegaHal" "" "Applications/Science/Social"
}
