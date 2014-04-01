# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit gnome2 toolchain-funcs eutils waf-utils

DESCRIPTION="Private digital diary"
HOMEPAGE="http://lifeograph.wikidot.com"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-cpp/gtkmm
	dev-cpp/gconfmm
	app-text/gtkspell
	dev-libs/libgcrypt"
RDEPEND="${DEPEND}"

WAF_BINARY="${S}/waf"

src_configure() {
	# this release's waf errors on --libdir
	tc-export AR CC CPP CXX RANLIB
	NO_WAF_LIBDIR=true waf-utils_src_configure
#	echo "CCFLAGS=\"${CFLAGS}\" LINKFLAGS=\"${LDFLAGS}\" ./waf --prefix=${EPREFIX}/usr configure"
#	CCFLAGS="${CFLAGS}" LINKFLAGS="${LDFLAGS}" ./waf \
#		"--prefix=${EPREFIX}/usr" \
#		configure || die "configure failed"
}

src_compile() {
	waf-utils_src_compile
}

src_install() {
	waf-utils_src_install
	dodoc README NEWS AUTHORS
	doman lifeograph.1
	domenu lifeograph.desktop
}
