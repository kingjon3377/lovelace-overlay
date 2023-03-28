# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
USE_RUBY="ruby27 ruby30 ruby31"
RUBY_FAKEGEM_VERSION="${PV}"
RUBY_FAKEGEM_RECIPE_TEST=rspec

inherit ruby-fakegem

DESCRIPTION="Converts Markdown or PolyTeX to HTML and LaTeX"
HOMEPAGE="https://polytexnic.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DEPEND="test? ( dev-tex/tralics )"
ruby_add_rdepend "dev-ruby/nokogiri dev-ruby/pygments_rb dev-ruby/msgpack"
ruby_add_rdepend "dev-ruby/json:2 dev-ruby/kramdown:2"
# We _presume_ these are test dependencies ...
ruby_add_bdepend "test? ( dev-ruby/rspec:2 )" # dev-ruby/simplecov:0.8 patched out
ruby_add_bdepend "dev-ruby/rake"

PATCHES=( "${FILESDIR}/${P}-drop-coverage.patch" )

# Several tests fail, apparently due to whitespace differences in generated HTML; TODO: check dep versions and report upstream
RESTRICT=test
