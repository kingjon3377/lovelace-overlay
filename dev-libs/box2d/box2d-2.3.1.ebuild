# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs eapi7-ver

MY_PN=Box2D

DESCRIPTION="Box2D is an open source physics engine written primarily for games."
HOMEPAGE="https://box2d.org"
SRC_URI="https://github.com/erincatto/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+doc"

RDEPEND="media-libs/freeglut"
DEPEND="${RDEPEND}
	>=dev-util/premake-4.4_beta5:4
	doc? ( app-doc/doxygen )"

# The package includes a test suite, but it's *graphical* programs for manual
# testing, not automated tests.

S="${WORKDIR}/${MY_PN}-${PV}/${MY_PN}"

src_prepare() {
	sed -i -e 's@StaticLib@SharedLib@' premake4.lua || die
	default
}

src_configure() {
	premake4 gmake || die
	sed -i -e "s@^ *ALL_LDFLAGS *+=@& -Wl,-soname,lib${MY_PN}.so.$(ver_cut 1)@" \
		Build/gmake/${MY_PN}.make || die
}

src_compile() {
	unset ARCH
	emake -C Build/gmake CXX=$(tc-getCXX) "${MY_PN}"
	if use doc; then
		cd Documentation || die
		doxygen || die
		rm -f API/html/*.{md5,map} || die
		cd "${S}" || die
	fi
	sed -e "s@lib/\${DEB_HOST_MULTIARCH}@$(get_libdir)@" -e "s@\${VER}@${PV}@" \
		"${FILESDIR}/${PN}.pc.in" > "${PN}.pc" || die
}

src_install() {
	newlib.so "Build/gmake/bin/Debug/lib${MY_PN}.so" "lib${MY_PN}.so.${PV}"
	dosym "lib${MY_PN}.so.${PV}" "/usr/$(get_libdir)/lib${MY_PN}.so.$(ver_cut 1)"
	dosym "lib${MY_PN}.so.$(ver_cut 1)" "/usr/$(get_libdir)/lib${MY_PN}.so"
	insinto /usr/$(get_libdir)/pkgconfig
	doins "${PN}.pc"
	dodoc Readme.txt Documentation/manual.docx Changes.txt
	use doc && dodoc -r Documentation/API/html
	find "${MY_PN}" -name \*.h | while read -r file;do
		dir="$(dirname "${file}")"
		dodir "/usr/include/${dir}"
		insinto "/usr/include/${dir}"
		doins "${file}"
	done
	dodir "/usr/$(get_libdir)/cmake/${MY_PN}"
	insinto "/usr/$(get_libdir)/cmake/${MY_PN}"
	doins "${MY_PN}/Use${MY_PN}.cmake"
}
