# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Useful utils from chiark.greenend.org.uk"
HOMEPAGE="https://www.chiark.greenend.org.uk"
SRC_URI=""

EGIT_REPO_URI="git://git.chiark.greenend.org.uk/~ian/chiark-utils.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-lang/tcl"

src_compile() {
	emake -C cprogs all
}

src_install() {
	for a in cprogs backup sync-accounts scripts; do
		LC_ALL=C emake -C ${a} -j1 prefix="${D}/usr" etcdir="${D}/etc" \
				varlib="${D}/var/lib" mandir="${D}/usr/share/man" \
				install install-docs install-examples
	done
	dodir /usr/share/doc/${PF}
	mv "${D}"/usr/share/doc/* "${D}"/usr/share/doc/${PF}
	dodoc debian/changelog
}
