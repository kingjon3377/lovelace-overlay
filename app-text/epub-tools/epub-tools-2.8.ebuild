# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.4.4

CABAL_FEATURES="bin test-suite"
inherit haskell-cabal

DESCRIPTION="Command line utilities for working with epub files"
HOMEPAGE="http://hub.darcs.net/dino/epub-tools"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
		test? ( dev-haskell/hunit:=
		)
		>=dev-haskell/cabal-1.8:=
		>=dev-haskell/epub-metadata-4.0:=
		dev-haskell/mtl:=
		dev-haskell/parsec:=
		dev-haskell/regex-compat:=
		dev-haskell/zip-archive:=
		>=dev-lang/ghc-7.4.1:=
"
