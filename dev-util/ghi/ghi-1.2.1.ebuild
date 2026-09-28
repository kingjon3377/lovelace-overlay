# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33 ruby34 ruby40"
RUBY_FAKEGEM_RECIPE_TEST=rspec3

inherit ruby-fakegem

DESCRIPTION="GitHub Issues command line interface"
HOMEPAGE="https://github.com/drazisil/ghi"
SRC_URI="https://github.com/drazisil/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

ruby_add_rdepend dev-ruby/json
ruby_add_rdepend dev-ruby/pygments_rb
ruby_add_bdepend dev-ruby/rake

PATCHES=( "${FILESDIR}/${P}-drop-simplecov.patch" )

RUBY_FAKEGEM_EXTRADOC=( README.md man/${PN}.1.html man/${PN}.1.ronn )
RUBY_FAKEGEM_GEMSPEC=${PN}.gemspec

all_ruby_install() {
	all_fakegem_install
	doman man/${PN}.1
}
