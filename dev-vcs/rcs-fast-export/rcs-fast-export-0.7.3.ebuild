# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby23 ruby24 ruby25 ruby26"

inherit ruby-ng

DESCRIPTION="fast-export from RCS to be imported into git"
HOMEPAGE="https://github.com/Oblomov/rcs-fast-export"
SRC_URI="https://github.com/Oblomov/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="freedist" # No license stated, see https://github.com/Oblomov/rcs-fast-export/issues/2
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

each_ruby_prepare() {
	sed -i -e "s@RFE_VERSION=\"git\"@RFE_VERSION=\"${PV}\"@" ${PN}.rb || die
}

each_ruby_install() {
	doruby ${PN}.rb
}

pkg_postinst() {
	ewarn "Are you sure you want rcs-fast-export, and not cvs-fast-export?"
}
