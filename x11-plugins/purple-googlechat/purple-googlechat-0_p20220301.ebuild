# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="libpurple plugin for new Google Chat protocol"
HOMEPAGE="https://github.com/EionRobb/purple-googlechat"

COMMIT_ID="1e89ad97e0927025d0329e285436616d55baaf42"
SRC_URI="https://github.com/EionRobb/purple-googlechat/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT_ID}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-libs/glib:2
	dev-libs/json-glib
	dev-libs/protobuf-c:=
	net-im/pidgin:=
	sys-libs/zlib"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default

	# Does not respect CFLAGS
	sed -i Makefile -e 's/-g -ggdb//g' || die
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		PKG_CONFIG="$(tc-getPKG_CONFIG)"
}

src_install() {
	emake \
		PKG_CONFIG="$(tc-getPKG_CONFIG)" \
		DESTDIR="${ED}" \
		install

	einstalldocs
}
