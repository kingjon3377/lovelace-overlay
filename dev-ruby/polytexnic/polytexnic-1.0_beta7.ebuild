# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
USE_RUBY="ruby21 ruby22 ruby23 ruby24" # jruby
RUBY_FAKEGEM_VERSION="${PV/_beta/.beta}"
RUBY_FAKEGEM_RECIPE_TEST=rspec

inherit ruby-fakegem

DESCRIPTION="Converts Markdown or PolyTeX to HTML and LaTeX"
HOMEPAGE="https://polytexnic.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

ruby_add_rdepend ">=dev-ruby/json-1.8.1:0 dev-ruby/kramdown dev-ruby/msgpack"
ruby_add_rdepend ">=dev-ruby/nokogiri-1.6.0 dev-ruby/pygments_rb"
# We _presume_ these are test dependencies ...
ruby_add_bdepend "test? ( >=dev-ruby/rspec-2.14.1:2 dev-ruby/simplecov:0.8 )"
