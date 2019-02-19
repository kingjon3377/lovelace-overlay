# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 latex-package

DESCRIPTION="LaTeX template for CreateSpace books"
HOMEPAGE="https://github.com/aginiewicz/createspace"
EGIT_REPO_URI="https://github.com/aginiewicz/createspace.git"
SRC_URI=""

LICENSE="ZLIB LPPL-1.3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-texlive/texlive-latexrecommended"

src_unpack() {
	git-r3_src_unpack
}

DOCS=( "README" "${PN}.pdf" "${FILESDIR}/documentation.textile.txt" )

src_compile() {
	default_src_compile
	texi2pdf -q -c --language=latex ${PN}.dtx || die
}

src_install() {
	latex-package_src_install
	if test -f "${D}/usr/share/doc/${PF}/documentation.textile.txt" -o \
			-f "${D}/usr/share/doc/${PF}/documentation.textile.txt.gz" -o \
			-f "${D}/usr/share/doc/${PF}/documentation.textile.txt.bz2" -o \
			-f "${D}/usr/share/doc/${PF}/documentation.textile.txt.xz"; then
		einfo "Docs from wiki were already installed"
	else
		dodoc "${FILESDIR}/documentation.textile.txt"
		test -f "${D}/usr/share/doc/${PF}/documentation.textile.txt" -o \
			-f "${D}/usr/share/doc/${PF}/documentation.textile.txt.gz" -o \
			-f "${D}/usr/share/doc/${PF}/documentation.textile.txt.bz2" -o \
			-f "${D}/usr/share/doc/${PF}/documentation.textile.txt.xz" || die
	fi
}
