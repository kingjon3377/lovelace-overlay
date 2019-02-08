# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.2.18

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="GDBMI interface (program-driven control of GDB)"
HOMEPAGE="http://neugierig.org/software/darcs/browse/?r=hgdbmi;a=summary"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/parsec:=[profile?]
		>=dev-lang/ghc-6.8.2:="
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2"
