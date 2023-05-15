# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby30 ruby31 ruby32"
PYTHON_COMPAT=( python3_{9..11} )

RUBY_FAKEGEM_NAME="pygments.rb"
MY_P="${RUBY_FAKEGEM_NAME}-${PV}"

RUBY_FAKEGEM_RECIPE_TEST="rake"
RUBY_FAKEGEM_RECIPE_DOC="none"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.adoc README.adoc"

RUBY_FAKEGEM_GEMSPEC="${RUBY_FAKEGEM_NAME}.gemspec"

inherit ruby-fakegem python-single-r1

DESCRIPTION="Pygments syntax highlighting in ruby"
HOMEPAGE="https://github.com/pygments/pygments.rb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
REQUIRED_USE+=" ${PYTHON_REQUIRED_USE}"

RUBY_S="${MY_P}"

RDEPEND+="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		>=dev-python/pygments-2.2.0[${PYTHON_USEDEP}]
		dev-python/simplejson[${PYTHON_USEDEP}]
	')"
DEPEND+=" test? ( ${RDEPEND} )"

ruby_add_rdepend ">=dev-ruby/multi_json-1.0.0"
ruby_add_bdepend "dev-ruby/rake-compiler"

PATCHES=(
	"${FILESDIR}/${P}-0001-Remove-gemspec-git-ls-files.patch"
	"${FILESDIR}/${P}-0007-no-relative-path-for-require-in-tests.patch"
	"${FILESDIR}/${P}-0010-Disable-the-test-expecting-a-timeout.patch"
	"${FILESDIR}/${P}-0013-test-drop-test-that-depends-on-Python-internals.patch"
	"${FILESDIR}/${P}-0014-no-relative-path-to-mentos-py.patch"
	"${FILESDIR}/${P}-0015-test-update-for-latest-pygments.patch"
	"${FILESDIR}/${P}-0016-Adopt-to-pygments-2.24.patch"
)

pkg_setup() {
	ruby-ng_pkg_setup
	python-single-r1_pkg_setup
}

all_ruby_prepare() {
	sed -i -e '/[Bb]undler/d' Rakefile || die
	sed -i -e "s:require_relative ':require './:" pygments.rb.gemspec || die
#	sed -i -e '/s.files/d' pygments.rb.gemspec || die
	python_fix_shebang lib/pygments/mentos.py
	rm -r vendor || die "removing bundled libs failed"
	eapply_user
}
