# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature toolchain-funcs

DESCRIPTION="file optimizer utility script"
HOMEPAGE="https://birds-are-nice.me/software/minuimus.html"
SRC_URI="https://birds-are-nice.me/software/${PN}.zip -> ${P}.zip"

S="${WORKDIR}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

# Dependencies adapted from Arch AUR PKGBUILD
RDEPEND="app-arch/brotli
	media-gfx/gif2png
	media-gfx/gifsicle
	virtual/imagemagick-tools
	media-gfx/jpegoptim
	media-libs/libjpeg-turbo
	media-libs/libwebp
	app-text/mupdf
	media-gfx/optipng
	app-arch/p7zip
	app-text/poppler
	app-text/qpdf
	app-arch/unrar
	app-arch/zip
	app-arch/advancecomp
	dev-lang/perl"
DEPEND="${RDEPEND}"
BDEPEND="app-arch/unzip"

PATCHES=( "${FILESDIR}/${P}_leanify_keep_icc.patch" )

pkg_postinst() {
	optfeature app-misc/Leanify "Augment optimization with additional tricks"
	optfeature media-libs/jbigkit "Suggested by Arch AUR"
}

src_prepare() {
	# apparently upstream identifies ImageMagick command-line tools as TOOL-im6; correct that
	sed -i -e 's/convert-im6/convert/g' -e 's/identify-im6/identify/g' ${PN}.pl || die
	sed -i -e 's@gcc@$(CC) $(CFLAGS)@' makefile || die
	tc-export CC
	default
}

src_install() {
	# 'install' target in makefile doesn't have any equivalent of $D, and doesn't ensure directories exist.
	dobin ${PN}_*_helper cab_analyze ${PN}.pl
	dodoc README.TXT CHANGELOG README
}
