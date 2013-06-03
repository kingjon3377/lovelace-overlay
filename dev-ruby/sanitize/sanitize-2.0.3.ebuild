# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_EXTRADOC="HISTORY.md README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Whitelist-based HTML sanitizer"
HOMEPAGE="https://github.com/rgrove/sanitize/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="${RDEPEND} dev-libs/libxml2:2"

ruby_add_rdepend ">=dev-ruby/nokogiri-1.4.4 !>=dev-ruby/nokogiri-1.6"

ruby_add_bdepend ">=dev-ruby/minitest-2.0.0 dev-ruby/rake"

# No tests
RESTRICT="test"
