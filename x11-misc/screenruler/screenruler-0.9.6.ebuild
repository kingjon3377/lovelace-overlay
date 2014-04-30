# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# From bug #107710 or the graaf overlay

EAPI=5

inherit eutils fdo-mime

DESCRIPTION="Ruler measure objects on your screen"
HOMEPAGE="http://gnomecoder.wordpress.com/screenruler/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

RDEPEND="dev-ruby/rcairo[ruby_targets_ruby19]
	dev-ruby/ruby-gtk2[ruby_targets_ruby19]
	dev-ruby/ruby-gettext[ruby_targets_ruby19]"

src_prepare() {
	epatch "${FILESDIR}/screenruler-bug831501.patch"
	sed -i -e "s/File.dirname(__FILE__)/'\/usr\/share\/screenruler'/" screenruler.rb
}

S="${WORKDIR}/${PN}"

# There is no installation mechanism in the tarball, so just put
# everything in the right place
src_install() {
	make_desktop_entry screenruler "Screen Ruler" screenruler-icon "Utility;Gnome;GTK;"

	insinto /usr/share/${PN}
	doins "${S}"/*.rb
	doins "${S}"/*glade*
	doins "${S}"/*.png
	insinto /usr/share/${PN}/utils
	doins "${S}"/utils/*

	exeinto /usr/share/${PN}
	doexe "${S}"/screenruler.rb

	dosym /usr/share/${PN}/screenruler.rb /usr/bin/screenruler
	dosym /usr/share/${PN}/screenruler-icon.png /usr/share/pixmaps/screenruler-icon.png
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
