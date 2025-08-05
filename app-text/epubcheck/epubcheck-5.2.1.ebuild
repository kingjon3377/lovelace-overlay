# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# TODO: Build from source; this will require packaging some dependencies

EAPI=8

inherit java-pkg-2

DESCRIPTION="Check conformity of ebooks to EPUB spec"
HOMEPAGE="https://github.com/w3c/epubcheck"
SRC_URI="https://github.com/w3c/${PN}/releases/download/v${PV}/${P}.zip"

LICENSE="BSD Apache-2.0 icu MPL-2.0 MIT W3C"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=virtual/jre-1.7:*"
RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"

src_install() {
	java-pkg_dojar ${PN}.jar
	java-pkg_dolauncher
}
