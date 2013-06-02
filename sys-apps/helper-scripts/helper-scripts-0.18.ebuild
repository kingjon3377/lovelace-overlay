# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
DESCRIPTION="Helper scripts for Debian/Ubuntu Linux systems and Subversion"
HOMEPAGE="http://www.knizefamily.net/russ/software/linux/helper-scripts/"
SRC_URI="http://www.knizefamily.net/debian/${P/-0/_0}-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="courier? ( mail-mta/courier )
	apt? ( app-arch/dpkg )
	subversion? ( dev-vcs/subversion )"
# apt? ( sys-apps/apt ) # Ebuild in sunrise, not main tree ...

IUSE="courier apt subversion"

S="${WORKDIR}/${PN}"

src_prepare() {
	rm -r debian
	use courier || rm scripts/debian/courierpw doc/debian/courier*
	use apt || {
		rm scripts/debian/system-update scripts/debian/sources
		rm doc/debian/system-update* doc/debian/sources*
		rm etc/debian/cron.daily/system-update
	}
	use subversion || {
		rm -r scripts/subversion doc/subversion etc/subversion
	}
}

src_install() {
	dobin scripts/*/*
	doman doc/*/*.?
	dodoc doc/*/*.sgml
	insinto /etc/cron.daily
	doins etc/debian/cron.daily/*
	insinto /etc/cron.hourly
	doins etc/debian/cron.d/*
	use subversion && {
		insinto /etc/
		doins etc/subversion/*
	}
}
