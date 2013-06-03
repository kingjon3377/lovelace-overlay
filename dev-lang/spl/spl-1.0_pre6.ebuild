# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs

DESCRIPTION="SPL Programming Language"
HOMEPAGE="http://www.clifford.at/spl/"
SRC_URI="http://www.clifford.at/spl/releases/${P/_/}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+sqlite +mysql +postgresql +xml +sdl +doc +kde +fann +opengl +vim-syntax"

DEPEND="sys-apps/coreutils
	dev-libs/libpcre
	sys-libs/readline
	dev-libs/expat
	net-misc/curl
	sys-apps/util-linux
	sqlite? ( dev-db/sqlite )
	mysql? ( dev-db/mysql )
	postgresql? ( dev-db/postgresql-base )
	xml? ( dev-libs/libxml2 dev-libs/libxslt )
	doc? ( app-text/texlive-core )
	kde? ( kde-base/smokekde )
	fann? ( sci-mathematics/fann )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P/_/}"

pkg_setup() {
	if use opengl && ! use kde; then
		ewarn "Apparently SPL-OpenGL is pretty meaningless without SPL-KDE."
	fi
	use doc || \
		ewarn "Disabling documentation-building may also disable building the documentation tool."
}

src_compile() {
	emake CC=$(tc-getCC) USER_CFLAGS="${CFLAGS}" USER_LDFLAGS="${LDFLAGS}" \
		prefix=/usr
	use doc && \
		emake CC=$(tc-getCC) USER_CFLAGS="${CFLAGS}" USER_LDFLAGS="${LDFLAGS}" \
		prefix=/usr spldoc
}

src_install() {
	emake DESTDIR="${D}" prefix=/usr install
	dodoc README* vgsuppress.txt
	use doc && dohtml spldoc/*html
	use doc && dodoc manual.tex
	docinto spldoc
	use doc && dodoc spldoc/*txt
	use vim-syntax && insinto /usr/share/vim/vimfiles/syntax && \
		doins syntax-spl.vim syntax-spltpl.vim
}

pkg_postinst() {
	use vim-syntax && \
		einfo "If syntax highlighting for SPL is not automatically enabled," && \
		einfo "the source says to add the following lines to your .vimrc :" && \
		einfo && \
		einfo 'au BufRead,BufNewFile *.spl,*.webspl set filetype=spl' && \
		einfo 'au BufRead,BufNewFile *.spltpl set filetype=spltpl' && \
		einfo
}
