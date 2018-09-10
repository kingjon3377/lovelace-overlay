# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Export scripts for various web sites"
HOMEPAGE="https://github.com/l0b0/export"
EGIT_REPO_URI="https://github.com/l0b0/export.git"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
# FIXME: Allow installing Google Calendar exporter. But it's a Python script.
IUSE="+librarything +wordpress" # google-calendar
REQUIRED_USE="|| ( librarything wordpress )" # google-calendar

RDEPEND="wordpress? (
		net-misc/wget
		net-misc/curl
		dev-lang/perl
	)
	librarything? (
		net-misc/wget
	)"
DEPEND=""

# "tests" are primarily Python syntax type checks
RESTRICT=test

src_compile() {
	# Makefile only runs tests and Python checks
	:
}

src_install() {
	use librarything && newbin LibraryThing.sh export-librarything.sh
	use wordpress && newbin WordPress.com.sh export-wordpress.com.sh
}
