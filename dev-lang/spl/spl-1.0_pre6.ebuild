# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="SPL Programming Language"
HOMEPAGE="http://www.clifford.at/spl/"
SRC_URI="http://www.clifford.at/spl/releases/${P/_/}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+sqlite +mysql +postgresql +xml +sdl +doc +fann +opengl +vim-syntax"

DEPEND="sys-apps/coreutils
	dev-libs/libpcre
	sys-libs/readline:0
	dev-libs/expat
	net-misc/curl
	sys-apps/util-linux
	sqlite? ( dev-db/sqlite:3 )
	mysql? ( dev-db/mysql:= )
	postgresql? ( dev-db/postgresql:= )
	xml? ( dev-libs/libxml2 dev-libs/libxslt )
	doc? ( app-text/texlive-core )
	fann? ( sci-mathematics/fann )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P/_/}"

pkg_setup() {
	if use opengl; then
		ewarn "Apparently SPL-OpenGL is pretty meaningless without SPL-KDE, which requires"
		ewarn "tools (kde-base/smokekde) no longer packaged in Gentoo."
	fi
	use doc || \
		ewarn "Disabling documentation-building may also disable building the documentation tool."
}

src_prepare() {
	sed -i -e 's/LDLIBS_DL =$/LDLIBS_DL = -ldl/' GNUmakefile || die
	sed -i -e 's/$(CC) $(LDFLAGS) $< $(LDLIBS) -o $@/$(CC) $< $(LDLIBS) -o $@ $(LDFLAGS)/' GNUmakefile || die
	sed -i -e 's;$(CC) $(LDFLAGS) webspl_common.o spl_modules/mod_cgi.o $< $(patsubst -lspl,$(SPL_OBJS),$(LDLIBS)) -o $@;$(CC) $< webspl_common.o spl_modules/mod_cgi.o $(patsubst -lspl,$(SPL_OBJS),$(LDLIBS)) -o $@ $(LDFLAGS);' GNUmakefile || die
	sed -i -e 's;$(CC) $(LDFLAGS) webspl_common.o httpsrv.o spl_modules/mod_cgi.o $< $(patsubst -lspl,$(SPL_OBJS),$(LDLIBS)) -o $@;$(CC) $< webspl_common.o httpsrv.o spl_modules/mod_cgi.o $(patsubst -lspl,$(SPL_OBJS),$(LDLIBS)) -o $@ $(LDFLAGS);' GNUmakefile || die
	default
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
	if use doc; then
		dodoc manual.tex
		docinto html
		dodoc spldoc/*html
		docinto spldoc
		dodoc spldoc/*txt
	fi
	use vim-syntax && insinto /usr/share/vim/vimfiles/syntax && \
		doins syntax-spl.vim syntax-spltpl.vim
}

pkg_postinst() {
	if use vim-syntax; then
		einfo "If syntax highlighting for SPL is not automatically enabled,"
		einfo "the source says to add the following lines to your .vimrc :"
		einfo
		einfo 'au BufRead,BufNewFile *.spl,*.webspl set filetype=spl'
		einfo 'au BufRead,BufNewFile *.spltpl set filetype=spltpl'
		einfo
	fi
}
