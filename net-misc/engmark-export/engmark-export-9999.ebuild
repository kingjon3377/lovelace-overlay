# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Export scripts for various web sites"
HOMEPAGE="https://gitlab.com/engmark/export"
EGIT_REPO_URI="https://gitlab.com/engmark/export.git"
EGIT_OVERRIDE_REPO_L0B0_MAKE_INCLUDES="https://gitlab.com/engmark/make-includes.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
# FIXME: Allow installing Google Calendar exporter. But it's a Python (2) script.
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

# "tests" are primarily Python syntax type checks
RESTRICT=test

src_compile() {
	# Makefile only runs tests and Python checks
	:
}

src_install() {
	use librarything && newbin LibraryThing.sh export-librarything.sh
	use wordpress && newbin WordPress.com.sh export-wordpress.com.sh
	dodoc README.markdown
}

pkg_postinst() {
	einfo "You may wish to add something like the following to your crontab:"
	einfo
	use librarything && einfo "@midnight ${EROOT}/usr/bin/export-librarything.sh \$LT_USER \$LT_PASSWORD \$LT_BACKUP_PATH"
	use wordpress && einfo "@midnight ${EROOT}/usr/bin/export-wordpress.com.sh \$WP_USER \$WP_PASSWORD \$WP_DOMAIN \$WP_BACKUP_PATH"
}
