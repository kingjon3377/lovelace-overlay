# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GUILE_COMPAT=( 2-2 3-0 )
PYTHON_COMPAT=( python3_{8..13} )
inherit guile-single python-single-r1

DESCRIPTION="Flexible implementation of a DICT server"
HOMEPAGE="https://puszcza.gnu.org.ua/projects/dico"
SRC_URI="https://download.gnu.org.ua/pub/release/${PN}/${P}.tar.bz2"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+preprocessor +guile +wordnet +python"

REQUIRED_USE="guile? ( ${GUILE_REQUIRED_USE} ) python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="preprocessor? ( sys-devel/m4 )
	wordnet? ( app-dicts/wordnet )
	python? ( ${PYTHON_DEPS} )"
DEPEND="${RDEPEND}
	guile? ( ${GUILE_DEPS} )"
BDEPEND="app-alternatives/bzip2
	python? ( ${PYTHON_DEPS} )"

PATCHES=( "${FILESDIR}/${P}-int-conversion.patch" )

src_prepare() {
	if use guile; then
		guile-single_src_prepare
	fi
}

pkg_setup() {
	if use guile; then
		guile-single_pkg_setup
	fi
	if use python; then
		python-single-r1_pkg_setup
	fi
}

src_configure() {
	my_args=(
		$(use_with guile)
		$(use_with wordnet)
		$(use_with python)
	)
	if use preprocessor; then
		my_args+=( DEFAULT_PREPROCESSOR="/usr/bin/m4 -s" )
	else
		my_args+=( --without-preprocessor )
	fi
	econf "${my_args[@]}"
}

src_install() {
	default
	if use guile; then
		guile_unstrip_ccache
	fi
}

src_test() {
	GUILE_AUTO_COMPILE=0 default
}
