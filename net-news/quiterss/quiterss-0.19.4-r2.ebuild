# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils xdg

DESCRIPTION="Qt-based RSS/Atom feed reader"
HOMEPAGE="https://quiterss.org"

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/QuiteRSS/quiterss.git"
	inherit git-r3
else
	SRC_URI="https://github.com/QuiteRSS/quiterss/archive/${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/QuiteRSS/quiterss/commit/4bd7f02379572a5942b318e2a83e2079a8330f42.patch -> ${P}-0011-fix-1309-deprecated.patch
		https://github.com/QuiteRSS/quiterss/commit/550a8b81094568ee5333685f8df4dbaa186ad09a.patch -> ${P}-0027-refactored-Copyright.patch
		https://github.com/QuiteRSS/quiterss/commit/08b9f01170c9b25a0c5bad380dd0fc7037c6544b.patch -> ${P}-0039-build-webview-switch-to-QtWebEngine-was-QtWebKit.patch"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

BDEPEND="
	dev-qt/linguist-tools:5
	virtual/pkgconfig
"
DEPEND="
	>=dev-db/sqlite-3.11.1:3
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5
	dev-qt/qtnetwork:5[ssl]
	dev-qt/qtprintsupport:5
	dev-qt/qtsingleapplication[X,qt5(+)]
	dev-qt/qtsql:5[sqlite]
	dev-qt/qtwebengine:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/0001-change-Webkit.-Webkit-alpha4.patch"
	"${FILESDIR}/0002-fix-1308-Option-View-Show-Hide-Browser.patch"
	"${FILESDIR}/0003-update-audioplayer.html-to-use-HTML5-control-instead.patch"
	"${FILESDIR}/0004-Update-videoplayer.html-to-use-HTML5-tag-instead-of-.patch"
	"${FILESDIR}/0005-fix.patch"
	"${FILESDIR}/0006-fix.patch"
	"${FILESDIR}/0007-change.patch"
	"${FILESDIR}/0008-fix-High-DPI.patch"
	"${FILESDIR}/0009-fix-1291-Esc.patch"
	"${FILESDIR}/0010-changed-Update-files-translations.patch"
	"${DISTDIR}/${P}-0011-fix-1309-deprecated.patch"
	"${FILESDIR}/0012-fix-deprecated-Qt4.patch"
	"${FILESDIR}/0013-refactored-Copyright.patch"
	"${FILESDIR}/0014-fix-deprecated-Qt4.patch"
	"${FILESDIR}/0016-fix-1349-AdBlock.-XFiles.patch"
	"${FILESDIR}/0017-fix-grammatical-error-in-itemcondition.cpp.patch"
	"${FILESDIR}/0018-fix-grammatical-error-in-parseobject.cpp.patch"
	"${FILESDIR}/0019-Update-INSTALL.patch"
	"${FILESDIR}/0020-Update-README.md.patch"
	"${FILESDIR}/0021-Update-README.md.patch"
	"${FILESDIR}/0024-Update-INSTALL-add-sqlite-dev-package-neccessary.patch"
	"${FILESDIR}/0025-Update-INSTALL-add-webkitwidgets-seem-necessary.patch"
	"${DISTDIR}/${P}-0027-refactored-Copyright.patch"
	"${FILESDIR}/0028-Install-appdata-file.patch"
	"${FILESDIR}/0032-Turkish-language-fixes.patch"
	"${FILESDIR}/0033-Fixes-of-translation-errors.patch"
	"${FILESDIR}/0034-Fix-a-translation-error-with-Export-to-OPML.patch"
	"${FILESDIR}/0035-Change-to-ndash-for-Russian-typography.patch"
	"${FILESDIR}/0036-Fix-a-small-inaccurate-with-one-status-string.patch"
	"${FILESDIR}/0037-Update-quiterss_ru.qph.patch"
	"${DISTDIR}/${P}-0039-build-webview-switch-to-QtWebEngine-was-QtWebKit.patch"
	"${FILESDIR}/0040-fix-webview-Find-in-Browser-via-search-panel.patch"
)

src_prepare() {
	default
	sed -e "s/exists(.git)/0/" -i QuiteRSS.pro || die
}

src_configure() {
	local myqmakeargs=(
		PREFIX="${EPREFIX}/usr"
		SYSTEMQTSA=1
	)
	eqmake5 "${myqmakeargs[@]}"
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	einstalldocs
}
