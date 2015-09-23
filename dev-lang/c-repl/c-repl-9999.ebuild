# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

#EGIT_REPO_URI="git://neugierig.org/c-repl.git"
#EGIT_REPO_URI="git://github.com/martine/c-repl.git"
#EGIT_REPO_URI="git://github.com/mpereira/c-repl.git"
EGIT_REPO_URI="git://github.com/berdario/c-repl.git"
CABAL_FEATURES="bin"
inherit eutils haskell-cabal git-2

DESCRIPTION="read-eval-print loop for C"
HOMEPAGE="http://neugierig.org/software/c-repl/"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-lang/ghc-6.8:=
	sys-devel/gcc:=
	dev-cpp/gccxml:=
	dev-haskell/hexpat:=
	sys-devel/gdb
	dev-haskell/hgdbmi:=
	dev-haskell/readline:=
	dev-haskell/c2hs:="
RDEPEND="${DEPEND}"

#src_prepare() {
#	sed -i -e 's:hexpat == 0.19.6:hexpat >= 0.19.6:' c-repl.cabal || die "sed failed"
#	sed -i -e 's,import Control.Exception,import Control.OldException,' \
#		GCCXML.hs || die "second sed failed"
#	epatch "${FILESDIR}/child.patch" || die "patching failed"
#}

src_install() {
	haskell-cabal_src_install
	dodoc README TODO
}
