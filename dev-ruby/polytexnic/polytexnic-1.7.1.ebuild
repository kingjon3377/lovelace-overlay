# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
USE_RUBY="ruby25 ruby26 ruby27" # ruby30 blocked by kramdown and pygments_rb
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

PATCHES=( "${FILESDIR}/${PN}-1.6.1-drop-coverage.patch" )

# Several tests fail, many with permission-denied errors accessing a pygments_rb file; TODO: check dep versions and report upstream
RESTRICT=test
