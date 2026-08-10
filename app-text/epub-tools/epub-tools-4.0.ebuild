# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="test-suite"
inherit haskell-cabal

DESCRIPTION="Command line utilities for working with epub files"
HOMEPAGE="https://codeberg.org/dinofp/epub-tools"
SRC_URI="https://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-haskell/epub-metadata-5.4:=
	dev-haskell/mtl:=
	dev-haskell/parsec:=
	dev-haskell/regex-compat:=
	dev-haskell/zip-archive:=
	dev-haskell/heredoc:=
	dev-haskell/optparse-applicative-dex:=
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
	test? ( dev-haskell/tasty-hunit )
"
