# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit git-r3 multilib toolchain-funcs

EGIT_REPO_URI="https://github.com/mehturt/pidgin.git"

DESCRIPTION="A collection of pidgin/finch plugins"
HOMEPAGE="https://github.com/mehturt/pidgin"
SRC_URI=""

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-im/pidgin
	dev-libs/glib:2"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i \
		-e '/^CC=/d' \
		-e 's/^CFLAGS=/CFLAGS+=/' \
		-e 's@~/.purple/plugins@$(DESTDIR)/usr/'"$(get_libdir)"'/purple-2/@g' \
		Makefile || die
}

src_compile() {
	CC="$(tc-getCC)" CFLAGS="${CFLAGS} ${LDFLAGS}"
}

src_install() {
	dodir /usr/$(get_libdir)/purple-2
	emake install DESTDIR="${D}"
	dodoc README
}
