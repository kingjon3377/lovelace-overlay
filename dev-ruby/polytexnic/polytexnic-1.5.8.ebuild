# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
USE_RUBY="ruby23 ruby24 ruby25" # ruby26
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
ruby_add_rdepend "dev-ruby/json:0 dev-ruby/kramdown"
# We _presume_ these are test dependencies ...
ruby_add_bdepend "test? ( dev-ruby/rspec:2 dev-ruby/simplecov:0.8 )"
ruby_add_bdepend "dev-ruby/rake"

# One test fails, possibly because tralics isn't current (TODO: check again after adding its version bump)
RESTRICT=test

each_ruby_prepare() {
	sed -i -e '/coveralls/d' -e '/SimpleCov/d' spec/spec_helper.rb Gemfile || die
}
