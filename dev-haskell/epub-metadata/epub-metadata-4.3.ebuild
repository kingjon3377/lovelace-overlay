# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.4.4

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Library for parsing epub document metadata"
HOMEPAGE="http://hub.darcs.net/dino/epub-metadata"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/hxt-9:=[profile?]
		dev-haskell/mtl:=[profile?]
		dev-haskell/regex-compat:=[profile?]
		dev-haskell/zip-archive:=[profile?]
		>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
		test? ( dev-haskell/hunit
		)
		>=dev-haskell/cabal-1.8"

src_install() {
	cabal_src_install
	extra_file_line=$(grep -n extra-source-files epub-metadata.cabal | cut -d: -f1)
	sed -e "1,$((extra_file_line - 1))d" -e '/^[         ]*$/q' epub-metadata.cabal | \
			cut -c 22- | grep -v -e '^[ 	]*$' -e ^testsuite -e ^util | \
			while read file; do
				# Note that some of the "files" are globs, thus quoting for dirname but not for dodoc.
				docinto $(dirname "${file}")
				dodoc ${file}
			done
}
