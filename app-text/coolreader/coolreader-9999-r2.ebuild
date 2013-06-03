# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="git://crengine.git.sourceforge.net/gitroot/crengine/crengine"

inherit wxwidgets cmake-utils git-2

HYP_ARCH="AlReader2.Hyphen.zip"

DESCRIPTION="CoolReader - reader of eBook files (fb2,epub,htm,rtf,txt)"
HOMEPAGE="http://www.coolreader.org/e-index.htm"
SRC_URI="hyphen? ( http://alreader.kms.ru/AlReader/${HYP_ARCH} )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+qt4 wxwidgets hyphen"

DEPEND="sys-libs/zlib
	media-libs/libpng
	virtual/jpeg
	media-libs/freetype
	wxwidgets? ( app-admin/eselect-wxwidgets
		>=x11-libs/wxGTK-2.8 )
	qt4? ( dev-qt/qtcore:4
		dev-qt/qtgui:4 )
	hyphen? ( app-arch/unzip )"
RDEPEND="${DEPEND}
	media-fonts/corefonts"

REQUIRED_USE="^^ ( wxwidgets qt4 )"

src_unpack() {
	git-2_src_unpack
	if 	use hyphen; then
		unpack ${HYP_ARCH}
	fi
}

src_prepare() {
	# fix for amd64
	if use amd64; then
		sed -e 's/unsigned int/unsigned long/g' -i "${WORKDIR}/${P}/crengine/src/lvdocview.cpp" \
		|| die "patching lvdocview.cpp for amd64 failed"
	fi
}

pkg_pretend() {
	. "${ROOT}/var/lib/wxwidgets/current"
	if [[ "${WXCONFIG}" -eq "none" ]]; then
	   	die "The wxGTK profile should be selected!"
	fi
}

src_configure() {
	CMAKE_USE_DIR="${WORKDIR}"/"${SRC_UNPACK}"/"${P}"
	CMAKE_BUILD_TYPE="Release"
	if use qt4; then
		mycmakeargs="-D GUI=QT"
	elif use wxwidgets; then
		. "${ROOT}/var/lib/wxwidgets/current"
		if [[ "${WXCONFIG}" -eq "none" ]]; then
	    	die "The wxGTK profile should be selected!"
		fi
		mycmakeargs="-D GUI=WX"
	else
	    die "Only one GUI must be selected"
	fi
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	if use hyphen; then
		insinto /usr/share/crengine
		find "${WORKDIR}" -name "*hyphen*pdb" -exec \
			doins {} \;
	fi
	dosym ../fonts/corefonts /usr/share/crengine/fonts
	dodoc "${FILESDIR}/README"
}
