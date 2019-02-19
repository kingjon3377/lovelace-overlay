# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

SRC_URI_BASE="ftp://ftp.informatik.uni-stuttgart.de/pub/archive/comp.sources/misc"
DESCRIPTION="Transpose text, making rows columns and vice versa"
HOMEPAGE="http://doc.marsu.ru/FreeBSD/upt/ch21_21.htm"
SRC_URI="${SRC_URI_BASE}/${PN}/part01.gz -> ${P}-part01.shar.gz"

LICENSE="freedist" # apparently---no license is given in _Unix Power Tools_
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""
DEPEND="${DEPEND}
	app-arch/sharutils"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"
	mkdir "${P}"
	unshar -d "${P}" *.shar || die
}

PATCHES=( "${FILESDIR}/fix_segfaults_etc.patch" )

src_prepare() {
	sed -i -e 's@cc@$(CC)@' Makefile || die
	default
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS} -DSYSV"
}

src_test() {
	emake test
}

src_install() {
	dobin ${PN}
}
