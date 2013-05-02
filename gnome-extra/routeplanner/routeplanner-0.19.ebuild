# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="A highway trip planner"
HOMEPAGE="http://sourceforge.net/projects/routeplanner/"
SRC_URI="mirror://debian/pool/main/r/routeplanner/${PN}_${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

# PyGTK because I believe it hard-depends on libglade-python, which I can't
# figure out how to install properly ... Another ebuild I created had
# dev-util/glade[python], but that's clearly gtk 3 only by now.
DEPEND="gnome-base/libglade:2.0
	dev-python/pygtk:2
	dev-python/libgnome-python:2"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	# From debian/rules
	echo "s/##VERSION##/`head -1 debian/changelog | sed -e 's/[^(]*(\([^)]*\).*/\1/'`/g" > sed-script \
		|| die "preparing sed script failed"
}

src_compile() {
	docbook2man debian/rplan.sgml > rplan.1 && docbook2man debian/gredit.sgml > gredit.1 \
		|| die "creating man pages failed"
}

src_install() {
	dobin rplan gredit
	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	gzip -9 *.rpl3 || die "compressing data files failed"
	sed -i -f sed-script rpdbase.py || die "editing rpdbase.py failed"
	doins *.glade2 gredit.py rp*.py *.rpl3.gz
	doman rplan.1 gredit.1
	ewarn "This, like some other packages I've made ebuilds for, ought to have symlink-man pages"
	ewarn "for the other commands those pages document."
	dodoc README RoutePlanner.guide TODO styleguide-routeplanner-na.txt
	dohtml faq.html
}

pkg_postinst() {
	ewarn "Installs Python source files outside of their proper place."
}
