# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit texlive-common

DESCRIPTION="A Makefile helper for LaTeX"
HOMEPAGE="http://gforge.inria.fr/projects/latex-utils/"
SRC_URI="http://gforge.inria.fr/frs/download.php/file/30927/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND="doc? ( dev-texlive/texlive-langfrench )"
RDEPEND="${DEPEND}
	sys-devel/make
	virtual/latex-base"

S=${WORKDIR}/${PN}-2.1.18

src_prepare() {
	sed -i -e 's@/usr/bin/env python$@/usr/bin/env python2@' src/latex-make.dtx || die
}

src_compile() {
	emake -C src
	emake -C src doc
	use doc && emake -C doc
}

src_install() {
	if use doc; then
		emake install prefix="${D}/usr" SCRIPTSDIR="${D}/${TEXMF_DIST_PATH}/scripts/${PN}" \
			DOCDIR="${D}/${TEXMF_DIST_PATH}/doc/latex/${PN}" LATEXDIR="${D}/${TEXMF_DIST_PATH}/tex/latex/${PN}" \
			LATEXCFGDIR="${D}/${TEXMF_PATH}/tex/latex/${PN}"
	else
		emake -j1 -C src install prefix="${D}/usr" SCRIPTSDIR="${D}/${TEXMF_DIST_PATH}/scripts/${PN}" \
			DOCDIR="${D}/${TEXMF_DIST_PATH}/doc/latex/${PN}" LATEXDIR="${D}/${TEXMF_DIST_PATH}/tex/latex/${PN}" \
			LATEXCFGDIR="${D}/${TEXMF_PATH}/tex/latex/${PN}"
	fi
	dodoc README
	texlive-common_handle_config_files
	pushd "${S}/src" > /dev/null
	for script in *.py;do
		dobin_texmf_scripts "texmf-dist/scripts/${PN}/${script}"
	done
	popd > /dev/null
	sed -i -e 's/\.py//' "${D}/usr/include/LaTeX.mk" || die
}
