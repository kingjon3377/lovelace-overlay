# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# From bug #107710 or the graaf overlay

EAPI=7

USE_RUBY="ruby30 ruby31 ruby32"

inherit ruby-ng desktop xdg-utils

DESCRIPTION="Ruler measure objects on your screen"
HOMEPAGE="https://gnomecoder.wordpress.com/screenruler/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

ruby_add_rdepend "dev-ruby/rcairo dev-ruby/ruby-gtk3 dev-ruby/ruby-gettext"

PATCHES=(
	"${FILESDIR}/screenruler-bug831501.patch"
	"${FILESDIR}/scr.patch"
)

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
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
