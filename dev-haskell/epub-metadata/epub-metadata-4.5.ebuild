# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.3.2

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Library for parsing and manipulating ePub files and OPF package data"
HOMEPAGE="https://hub.darcs.net/dino/epub-metadata http://ui3.info/d/proj/epub-metadata.html"
SRC_URI="https://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="amd64 ~x86"

RDEPEND=">=dev-haskell/hxt-9:=[profile?]
		dev-haskell/utf8-string:=[profile?]
		dev-haskell/mtl:=[profile?]
		dev-haskell/regex-compat:=[profile?]
		dev-haskell/zip-archive:=[profile?]
		dev-haskell/regex-compat-tdfa:=[profile?]
		>=dev-lang/ghc-8.0.1:="
DEPEND="${RDEPEND}
		test? ( dev-haskell/hunit
		)
		>=dev-haskell/cabal-1.8"
BDEPEND=">=dev-lang/ghc-8.0.1"

src_prepare() {
	if has_version '<=dev-haskell/binary-0.5.1.1'; then
		sed -i testsuite/Archive.hs \
			-e 's/Data.Binary.Get.runGet at position 138: Did not find end of central directory signature/Did not find end of central directory signature. Failed reading at byte position 138/' || die
	fi
	default
}

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
