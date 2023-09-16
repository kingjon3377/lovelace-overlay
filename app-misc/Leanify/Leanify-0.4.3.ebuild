# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="lightweight lossless file minifier/optimizer"
HOMEPAGE="https://github.com/JayXon/Leanify"
SRC_URI="https://github.com/JayXon/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

IUSE="cpu_flags_x86_sse2"

PATCHES=( "${FILESDIR}/${P}-unset-cflags.patch" )

# TODO: Unbundle any bundled libraries

src_prepare() {
	default
	sed -i -e 's@^	ar @	$(AR) @' Makefile || die
}

src_compile() {
	cflags="${CFLAGS}"
	use cpu_flags_x86_sse2 && cflags="${cflags} -msse2 -mfpmath=sse"
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" CFLAGS="${cflags}" LDFLAGS="${LDFLAGS}" AR="$(tc-getAR)"
}

DOCS=( README.md CHANGELOG.md )

src_install() {
	dobin "${PN,}"
	einstalldocs
}
