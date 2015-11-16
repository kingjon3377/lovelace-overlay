# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

USE_RUBY="ruby20 ruby21"

inherit git-r3 ruby-ng

DESCRIPTION="fast-export from RCS to be imported into git"
HOMEPAGE="https://github.com/Oblomov/rcs-fast-export"
SRC_URI=""
EGIT_REPO_URI="https://github.com/Oblomov/rcs-fast-export.git"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

all_ruby_unpack() {
	git-r3_src_unpack
	cd "${WORKDIR}"
	mv "${P}" all
}

each_ruby_install() {
	doruby ${PN}.rb
}

pkg_postinst() {
	ewarn "Are you sure you want rcs-fast-export, and not cvs-fast-export?"
}
