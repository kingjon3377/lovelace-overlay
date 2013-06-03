# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_DEPEND="2:2.5"
PYTHON_MODNAME="libbe"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit eutils distutils

if [[ ${PV} == "9999" ]] ; then
	inherit git-2
	EGIT_BRANCH="master"
	EGIT_REPO_URI="git://gitorious.org/be/be.git"
	SRC_URI=""
else
	SRC_URI="http://bugseverywhere.org/releases/be-${PV}.tar.gz"
fi

DESCRIPTION="distributed bug tracking system using VCS storage"
HOMEPAGE="http://bugseverywhere.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bash-completion"

RDEPEND="dev-lang/python
	dev-python/jinja
	dev-python/pyyaml"
DEPEND="${RDEPEND}
	dev-vcs/git
	dev-python/docutils"

# Tests depend on too many VCSes and apparently-randomly break.
RESTRICT="test"

src_unpack() {
	if [[ ${PV} == "9999" ]] ; then
		git-2_src_unpack
	else
		unpack ${A}
	fi
	cd "${S}"
}

src_prepare() {
	distutils_src_prepare
}

src_compile() {
	make libbe/_version.py || die "_version.py generation failed"
	emake RST2MAN="/usr/bin/rst2man.py" doc/man/be.1
	distutils_src_compile
}

src_install() {
	distutils_src_install
	dodoc AUTHORS NEWS README
	if [[ ${PV} != "9999" ]] ; then
		dodoc ChangeLog
	fi
	if use bash-completion ; then
		insinto /etc/bash_completion.d/
		newins misc/completion/be.bash be
	fi
}
