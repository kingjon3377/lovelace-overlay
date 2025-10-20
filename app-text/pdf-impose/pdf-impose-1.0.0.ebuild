# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby27 ruby30 ruby31 ruby32"
RUBY_FAKEGEM_VERSION="${PV}"

inherit ruby-fakegem

DESCRIPTION="Utility and library for imposition"
HOMEPAGE="https://github.com/jamis/impose"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

ruby_add_rdepend "dev-ruby/pdf-reader dev-ruby/prawn:2 dev-ruby/prawn-templates"

# No tests in gem
RESTRICT=test

RUBY_FAKEGEM_EXTRADOC=( README.md )
