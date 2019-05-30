# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit texlive-common

DESCRIPTION="A Makefile helper for LaTeX"
HOMEPAGE="http://gforge.inria.fr/projects/latex-utils/"
#SRC_URI="http://gforge.inria.fr/frs/download.php/file/30927/${P}.tar.gz"
SRC_URI="http://gforge.inria.fr/frs/download.php/zip/10626/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

CDEPEND="dev-texlive/texlive-langfrench"
RDEPEND="${CDEPEND}
	sys-devel/make
	virtual/latex-base"
DEPEND="${CDEPEND}"
BDEPEND="app-arch/unzip"

src_unpack() {
	default
	unpack "${WORKDIR}/${P}.tar.gz"
	rm "${WORKDIR}/${P}.tar.gz"
}

src_configure() {
	# It aborts on unrecognized options, such as those provided by econf
	./configure --prefix=/usr --texmf-prefix=/usr/share/texmf || die
}

src_test() {
	emake check
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
	dodoc README Changelog
	texlive-common_handle_config_files
	pushd "${S}/src" > /dev/null
	for script in *.py;do
		dobin_texmf_scripts "texmf-dist/scripts/${PN}/${script}"
	done
	popd > /dev/null
	sed -i -e 's/\.py//' "${D}/usr/include/LaTeX.mk" || die
}
