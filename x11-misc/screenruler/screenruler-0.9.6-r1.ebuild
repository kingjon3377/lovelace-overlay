# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# From bug #107710 or the graaf overlay

EAPI=5

USE_RUBY="ruby21 ruby22 ruby23 ruby24"

inherit ruby-ng eutils fdo-mime

DESCRIPTION="Ruler measure objects on your screen"
HOMEPAGE="http://gnomecoder.wordpress.com/screenruler/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

ruby_add_rdepend "dev-ruby/rcairo dev-ruby/ruby-gtk2 dev-ruby/ruby-gettext"

RUBY_PATCHES=( "${FILESDIR}/screenruler-bug831501.patch" )

#src_prepare() {
	#sed -i -e "s/File.dirname(__FILE__)/'\/usr\/share\/screenruler'/" screenruler.rb
#}

RUBY_S=${PN}

each_ruby_install() {
	# Borrowing from doruby
	sitelibdir=$(ruby_rbconfig_value 'sitelibdir')
	insinto "${sitelibdir#${EPREFIX}}/${PN}"
	doins *.rb *glade* *.png
	doins -r utils
	fperms +x "${sitelibdir#${EPREFIX}}/${PN}/${PN}.rb"
	if ! test -d "${D}/usr/bin" ; then
		dodir /usr/bin
		dosym "../../${sitelibdir#${EPREFIX}}/${PN}/${PN}.rb" /usr/bin/${PN}
	fi
	if ! test -d "${D}/usr/share/pixmaps"; then
		dodir /usr/share/pixmaps
		dosym "../../../${sitelibdir#${EPREFIX}}/${PN}/${PN}-icon.png" /usr/share/pixmaps/${PN}-icon.png
	fi
}

all_ruby_install() {
	make_desktop_entry ${PN} "Screen Ruler" ${PN}-icon "Utility;Gnome;Gtk;"
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
