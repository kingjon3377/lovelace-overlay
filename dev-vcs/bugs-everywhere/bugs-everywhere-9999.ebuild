# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_DEPEND="2:2.5"
PYTHON_MODNAME="libbe"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

PYTHON_COMPAT=( python2_7 )
inherit eutils distutils-r1

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
IUSE=""

RDEPEND="dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-vcs/git[python,${PYTHON_USEDEP}]
	dev-python/docutils[${PYTHON_USEDEP}]"

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

src_compile() {
	make libbe/_version.py || die "_version.py generation failed"
	emake RST2MAN="/usr/bin/rst2man.py" doc/man/be.1
	distutils-r1_src_compile
}

src_install() {
	distutils-r1_src_install
	dodoc AUTHORS NEWS README
	if [[ ${PV} != "9999" ]] ; then
		dodoc ChangeLog
	fi
	insinto /etc/bash_completion.d/
	newins misc/completion/be.bash be
}
