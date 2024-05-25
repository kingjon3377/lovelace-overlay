# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby31 ruby32 ruby33"

inherit ruby-fakegem

DESCRIPTION="Style checker/lint tool for markdown files"
HOMEPAGE="https://rubygems.org/gems/mdl https://github.com/markdownlint/markdownlint"
SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

ruby_add_rdepend "dev-ruby/kramdown dev-ruby/kramdown-parser-gfm dev-ruby/mixlib-config"
ruby_add_rdepend "dev-ruby/mixlib-shellout dev-ruby/mixlib-cli"

ruby_add_bdepend "dev-ruby/rake dev-ruby/bundler"
ruby_add_bdepend "test? ( dev-ruby/minitest dev-ruby/pry )"

PATCHES=( "${FILESDIR}/markdownlint-0.13.0-d22747ee9b66eafe232107a1fcd408eab4e1d3b4.patch" )

all_ruby_prepare() {
	sed -i -e "/'pry'/d" -e '/rubocop/d' mdl.gemspec || die
}
