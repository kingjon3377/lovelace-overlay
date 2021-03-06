# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby23 ruby24 ruby25 ruby26 ruby27"
PYTHON_COMPAT=( python3_{6..9} )

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
		>=dev-python/pygments-2.2.0[${PYTHON_MULTI_USEDEP}]
		dev-python/simplejson[${PYTHON_MULTI_USEDEP}]
	')"
DEPEND+=" test? ( ${RDEPEND} )"

ruby_add_rdepend ">=dev-ruby/multi_json-1.0.0"
ruby_add_bdepend "dev-ruby/rake-compiler"

pkg_setup() {
	ruby-ng_pkg_setup
	python-single-r1_pkg_setup
}

all_ruby_prepare() {
	sed -i -e '/[Bb]undler/d' Rakefile || die
	sed -i -e '/s.files/d' pygments.rb.gemspec || die
	python_fix_shebang lib/pygments/mentos.py
	# we are loosing a "custom github lexer here", no idea what it is,
	# but if we need it, it should go into dev-python/pygments
	rm -r vendor lexers || die "removing bundled libs failed"
	eapply_user
}

each_ruby_compile() {
	# regenerate the lexer cache, based on the system pygments pkg
	${RUBY} cache_lexers.rb || die "regenerating lexer cache failed"
}

each_ruby_install() {
	each_fakegem_install
	ruby_fakegem_doins lexers
}
