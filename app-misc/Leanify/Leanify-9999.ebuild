# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs

DESCRIPTION="lightweight lossless file minifier/optimizer"
HOMEPAGE="https://github.com/JayXon/Leanify"
EGIT_REPO_URI="https://github.com/JayXon/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-unset-cflags.patch" )

# TODO: Unbundle any bundled libraries

src_compile() {
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" CXXFLAGS="${CXXFLAGS}" # CPPFLAGS="${CPPFLAGS}"
}

DOCS=( README.md CHANGELOG.md SECURITY.md )

src_install() {
	dobin "${PN,}"
	einstalldocs
}
