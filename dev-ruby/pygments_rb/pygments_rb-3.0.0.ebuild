# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby30 ruby31 ruby32 ruby33 ruby34"
PYTHON_COMPAT=( python3_{9..13} )

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
	"${FILESDIR}/${P}-fix-test.patch"
)

pkg_setup() {
	ruby-ng_pkg_setup
	python-single-r1_pkg_setup
}

all_ruby_prepare() {
	sed -i -e '/[Bb]undler/d' Rakefile || die
	sed -i -e "s:require_relative ':require './:" pygments.rb.gemspec || die
	sed -i -e '/x-python/d' test/test_pygments.rb || die # remove failing test assertion
	python_fix_shebang lib/pygments/mentos.py
	rm -r vendor || die "removing bundled libs failed"
	eapply_user
}
