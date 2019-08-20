# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Password recovery for 7zip, rar and zip archives"
HOMEPAGE="http://rarcrack.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="7zip rar zip test"

CDEPEND="dev-libs/libxml2"
RDEPEND="${CDEPEND}
	rar? ( app-arch/unrar )
	zip? ( app-arch/unzip )
	7zip? ( app-arch/p7zip )
"
DEPEND="${CDEPEND}
	test? (
		app-arch/unrar
		app-arch/unzip
		app-arch/p7zip
	)"

PATCHES=(
	"${FILESDIR}/rarcrack-cflags.patch"
	"${FILESDIR}/rarcrack-mime.patch"
)

src_prepare() {
	default
	sed -i -e 's:install -s:install:' -e 's:LICENSE ::' Makefile \
		-e 's/=/?=/' || die "sed failed"
}

src_compile() {
	CC="$(tc-getCC)" CFLAGS="${CFLAGS}" default_src_compile
}

src_install() {
	dodir /usr/bin
	PREFIX="${D}/usr" DOCDIR="${D}/usr/share/doc/${PF}" emake install
}

src_test() {
	cp test.7z test.rar test.zip "${T}" || die
	cd "${T}" || die
	for ftype in 7z rar zip; do
		"${S}/${PN}" test.${ftype} || die
	done
}
