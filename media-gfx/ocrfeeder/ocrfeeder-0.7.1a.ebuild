# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# From bug #333309

EAPI=5
PYTHON_DEPEND="2:2.5"
inherit gnome2-utils distutils

MY_P="${P}"
DESCRIPTION="Optical Character Recognition and Document Analysis and Recognition for GNOME."
HOMEPAGE="http://live.gnome.org/OCRFeeder"
SRC_URI="http://ftp.gnome.org/pub/GNOME/sources/${PN}/0.7/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+ocrad +gocr +tesseract"

RDEPEND=">=dev-python/pygtk-2.13
	>=dev-python/imaging-1.1
	>=dev-python/pygoocanvas-0.12
	>=app-text/ghostscript-gpl-8.63
	>=app-text/unpaper-0.3
	ocrad? ( app-text/ocrad )
	gocr? ( app-text/gocr )
	tesseract? ( app-text/tesseract )"

DEPEND=""

REQUIRED_USE="|| ( ocrad gocr tesseract )"
pkg_setup() {
	echo
	einfo "The configuration XML file for the engine Ocrad is already included"
	einfo "with the project. In case the you doesn't want to use Ocrad, the"
	einfo "configuration file that is placed in the OCRFeeder's configuration "
	einfo "folder (~/.ocrfeeder) should perhaps be deleted."
	echo
}

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	distutils_pkg_postinst
	gnome2_icon_cache_update

	echo
	elog "The configuration XML file for the engine Ocrad is already included"
	elog "with the project. In case the you doesn't want to use Ocrad, the"
	elog "configuration file that is placed in the OCRFeeder's configuration"
	elog "folder (~/.ocrfeeder) should perhaps be deleted."
	echo
}
