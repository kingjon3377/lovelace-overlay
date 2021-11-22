# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Useful utils from chiark.greenend.org.uk"
HOMEPAGE="https://www.chiark.greenend.org.uk"
SRC_URI=""

EGIT_REPO_URI="https://www.chiark.greenend.org.uk/ucgi/~ian/githttp/chiark-utils.git"

# TODO: Split into multiple packages, following Debian packaging, or at least split via USE flags

# TODO: Package upstream VCS tags as versions which can then be stabilized

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-libs/libX11
	x11-libs/libXmu
	dev-libs/nettle:=
	x11-libs/libXdmcp
	x11-libs/libXau
	x11-libs/libICE
	x11-libs/libSM
	dev-libs/gmp:="
RDEPEND="${DEPEND}
	dev-lang/tcl
	dev-perl/Git-Wrapper
	dev-perl/Try-Tiny"

src_prepare() {
	sed -i -e "s@/doc/\$(us)@/doc/${PF}/\$(us)@" settings.make || die
	sed -i -e "s@/doc/@/doc/${PF}/@" sync-accounts/Makefile || die
	default
}

src_compile() {
	emake -C cprogs all
}

src_install() {
	for a in cprogs backup sync-accounts scripts fishdescriptor; do
		LC_ALL=C emake -C ${a} -j1 prefix="${D}/usr" etcdir="${D}/etc" \
				varlib="${D}/var/lib" mandir="${D}/usr/share/man" \
				install install-docs install-examples
	done
	dodoc debian/changelog
	keepdir /var/lib/chiark-backup
}
