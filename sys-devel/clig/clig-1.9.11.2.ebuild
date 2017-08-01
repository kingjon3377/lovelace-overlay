# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils multilib

DESCRIPTION="Command Line Interpreter Generator"
SRC_URI="http://bsdforge.com/projects/source/devel/${PN}/${P}.tar.xz"
HOMEPAGE="http://bsdforge.com/projects/devel/clig/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/tcl:="
DEPEND="${RDEPEND}
	app-arch/xz-utils"

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}/clig_makefile_patch.patch"
	sed -i -e 's:)/man:)/share/man:g' -e "s:/lib/:/$(get_libdir)/:" makefile \
			|| die "sed failed"
}

src_compile() {
	emake prefix=/usr
}

src_install() {
	emake install build_root="${D}" prefix=/usr
}
