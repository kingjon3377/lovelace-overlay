# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby30 ruby31 ruby32 ruby33 ruby34"

inherit ruby-ng optfeature

DESCRIPTION="fast-export from RCS to be imported into git"
HOMEPAGE="https://github.com/Oblomov/rcs-fast-export"
SRC_URI="https://github.com/Oblomov/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="freedist" # No license stated, see https://github.com/Oblomov/rcs-fast-export/issues/2
SLOT="0"
KEYWORDS="~amd64"

each_ruby_prepare() {
	sed -i -e "s@RFE_VERSION=\"git\"@RFE_VERSION=\"${PV}\"@" ${PN}.rb || die
}

each_ruby_install() {
	doruby ${PN}.rb
}

pkg_postinst() {
	optfeature "you probably want instead" dev-vcs/cvs-fast-export
}
