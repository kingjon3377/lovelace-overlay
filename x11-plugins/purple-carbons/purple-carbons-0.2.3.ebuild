# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Experimental XEP-0280: Message Carbons plugin for libpurple"
HOMEPAGE="https://github.com/gkdr/carbons"
SRC_URI="https://github.com/gkdr/carbons/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="net-im/pidgin:=
	dev-libs/glib:2
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	test? ( dev-util/cmocka )
	virtual/pkgconfig"

S=${WORKDIR}/carbons-${PV}

RESTRICT="!test? ( test )"

DOCS=( CHANGELOG.md README.md )

src_prepare() {
	default
	sed -i -e "s#\~/.purple/plugins#\$(DESTDIR)/usr/$(get_libdir)/pidgin/#"\
		Makefile || die
}

src_compile() {
	CC=$(tc-getCC) emake
}

src_test() {
	CC=$(tc-getCC) default
}

src_install() {
	CC=$(tc-getCC) default
}
