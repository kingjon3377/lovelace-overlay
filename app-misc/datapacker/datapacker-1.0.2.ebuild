# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.2.18

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="Tool to help pack files into the minimum number of CDs/DVDs/etc"
HOMEPAGE="http://software.complete.org/datapacker https://github.com/jgoerzen/datapacker"
SRC_URI="https://github.com/jgoerzen/${PN}/archive/debian/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-0:=
		dev-haskell/hslogger:=
		>=dev-haskell/missingh-1.0.1:=
		dev-haskell/mtl:=
		>=dev-lang/ghc-6.10.1:="
BDEPEND=">=dev-lang/ghc-6.10.1
	app-text/docbook-sgml-utils"

S="${WORKDIR}/${PN}-debian-${PV}"

src_compile() {
	default
	emake man
}

src_install() {
	dobin dist/build/${PN}/${PN}
	doman ${PN}.1
}
