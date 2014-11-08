# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# I doubt it's compatible with Python 3
PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

DESCRIPTION="Load upstream archives into a new VCS"
HOMEPAGE="https://github.com/jgoerzen/vcs-load-dirs/wiki"
SRC_URI="mirror://debian/pool/main/v/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
#IUSE="+mercurial arch +git svk +darcs"
IUSE="+mercurial +git +darcs"

DEPEND=""
RDEPEND="${DEPEND}
	mercurial? ( dev-vcs/mercurial[${PYTHON_USEDEP}] )
	git? ( dev-vcs/git[${PYTHON_USEDEP}] )
	darcs? ( dev-vcs/darcs )"

src_compile() {
	distutils-r1_src_compile
	emake -C docs text manpages
}

src_install() {
	distutils-r1_src_install
	rm "${D}/usr/bin/baz_load_dirs"
	use mercurial || rm "${D}/usr/bin/hg_load_dirs"
	rm "${D}/usr/bin/tla_load_dirs"
	use git || rm "${D}/usr/bin/git_load_dirs"
	rm "${D}/usr/bin/svk_load_dirs"
	use darcs || rm "${D}/usr/bin/darcs_load_dirs"
	doman docs/vcs_load_dirs.1
	dodoc docs/vcs_load_dirs.{txt,sgml}
	use mercurial && doman docs/hg_load_dirs.1
	use git && doman docs/git_load_dirs.1
	use darcs && doman docs/darcs_load_dirs.1
}
