# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="hgsubversion is a Mercurial extension for working with Subversion repositories"
HOMEPAGE="https://bitbucket.org/durin42/hgsubversion/wiki/Home https://pypi.org/project/hgsubversion/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~ppc-macos ~x64-macos ~x86-solaris"
IUSE="test"

RDEPEND="
	>=dev-vcs/mercurial-3.7[${PYTHON_USEDEP}]
	|| (
		>=dev-python/subvertpy-0.7.4[${PYTHON_USEDEP}]
		>=dev-vcs/subversion-1.5[python] )
"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )
"

PATCHES=(
	"${FILESDIR}/01_drop_hg_3.3_compat_74c5fd9c3e762d82ee8957acd384d00dc91fc2cb.patch"
	"${FILESDIR}/02_support_treemanifest_04a24a13960ff1545a49707541e748de191304dd.patch"
	"${FILESDIR}/03_update_README_b06be581569214a07a2f309ee3287a0c5e6c5793.patch"
	"${FILESDIR}/04_drop_more_obsolete_compat_394007c5efea9c6bcd6483243432832883e32a3a.patch"
	"${FILESDIR}/05_drop_branchset_7bb6562feb85c1cc628b18171d50695b43abb6f8.patch"
	"${FILESDIR}/06_use_ui_write_6f5b296c01dde197abe393c0415fb98e25c62ba9.patch"
	"${FILESDIR}/07_progress_deprecation_compat_5d8603f080c5bb38ec7ed7792d983397113cd0ee.patch"
	"${FILESDIR}/08_memfilectx_compat_6a6ce9d9da352801d30263178db6ba3f1637c197.patch"
)

python_test() {
#	"${PYTHON}" tests/run.py || die "Tests failed under ${EPYTHON}"
	# Upstream is using nose and the other way simply runs no tests
	LC_ALL=C nosetests --verbose || die
}
