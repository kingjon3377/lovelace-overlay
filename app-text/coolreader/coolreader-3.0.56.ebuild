# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit wxwidgets cmake-utils

HYP_ARCH="AlReader2.Hyphen.zip"

DESCRIPTION="CoolReader - reader of eBook files (fb2,epub,htm,rtf,txt)"
HOMEPAGE="http://www.coolreader.org/e-index.htm"
SRC_URI="mirror://sourceforge/crengine/CoolReader3/cr3-${PV}/cr3_${PV}.orig.tar.gz
	hyphen? ( http://alreader.kms.ru/AlReader/${HYP_ARCH} )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="+qt4 wxwidgets hyphen"

DEPEND="sys-libs/zlib
	media-libs/libpng:0
	virtual/jpeg:0
	media-libs/freetype
	wxwidgets? ( app-eselect/eselect-wxwidgets
		x11-libs/wxGTK:2.8 )
	qt4? ( dev-qt/qtcore:4
		dev-qt/qtgui:4 )
	hyphen? ( app-arch/unzip )"
RDEPEND="${DEPEND}
	media-fonts/corefonts"

S="${WORKDIR}/cr${PV}-7"

REQUIRED_USE="^^ ( wxwidgets qt4 )"

src_prepare() {
	# fix for amd64
	if use amd64; then
		sed -e 's/unsigned int/unsigned long/g' -i "${S}/crengine/src/lvdocview.cpp" \
		|| die "patching lvdocview.cpp for amd64 failed"
	fi
	sed -i -e 's@<freetype/@<freetype2/freetype/@' \
		"${S}/crengine/src/lvfntman.cpp" \
		|| die
}

pkg_pretend() {
	if use wxwidgets; then
		. "${ROOT}/var/lib/wxwidgets/current"
		if [[ "${WXCONFIG}" == "none" ]]; then
	   		die "The wxGTK profile should be selected!"
		fi
	fi
}

src_configure() {
	CMAKE_BUILD_TYPE="Release"
	if use qt4; then
		mycmakeargs="-DGUI=QT"
	elif use wxwidgets; then
		. "${ROOT}/var/lib/wxwidgets/current"
		if [[ "${WXCONFIG}" -eq "none" ]]; then
	    	die "The wxGTK profile should be selected!"
		fi
		mycmakeargs="-DGUI=WX"
	else
	    die "Only one GUI must be selected"
	fi
	mycmakeargs="${mycmakeargs} -DDOC_DATA_COMPRESSION_LEVEL=3"
	mycmakeargs="${mycmakeargs} -DDOC_BUFFER_SIZE=0x2500000 -DMAX_IMAGE_SCALE_MUL=2"
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
#	dodoc "${FILESDIR}/README"
}
