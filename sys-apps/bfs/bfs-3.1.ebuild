# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Breadth-first 'find'"
HOMEPAGE="https://tavianator.com/projects/bfs.html https://github.com/tavianator/bfs"
SRC_URI="https://github.com/tavianator/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="0BSD"
SLOT="0"
KEYWORDS="~amd64"

# TODO: liburing, removing disabling flag below, if it passes its tests on a more recent kernel
DEPEND="sys-apps/acl
	sys-apps/attr
	sys-libs/libcap
	dev-libs/oniguruma
	"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	default
	ebegin "Disabling uring"
	sed -i -e 's@^USE_LIBURING := y$@undefine USE_LIBURING@' GNUmakefile || die
	eend
}

src_compile() {
	emake USE_LIBURING= CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_test() {
	emake check
}
