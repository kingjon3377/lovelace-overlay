# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyQt/PyQt-3.18.1.ebuild,v 1.8 2009/10/18 14:41:15 armin76 Exp $

EAPI=5
PYTHON_COMPAT=( python2_{6,7} )
inherit python-r1 eutils

MY_P="PyQt-x11-gpl-${PV/*_pre/snapshot-}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A set of Python bindings for Qt3"
HOMEPAGE="http://www.riverbankcomputing.co.uk/software/pyqt/intro/"
SRC_URI="http://www.riverbankcomputing.com/static/Downloads/PyQt3/${MY_P}.tar.gz"
SRC_URI="mirror://sourceforge/pyqt/${PN}3/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE="debug doc examples"

RDEPEND="dev-qt/qt-meta:3
	>=dev-python/sip-4.8.1[${PYTHON_USEDEP}]
	>=dev-python/qscintilla-python-2.3[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	sys-devel/libtool"

src_prepare() {
	epatch "${FILESDIR}/python-qt3-with-sip-4.15.diff"
	sed -i -e "s:  check_license():# check_license():" "${S}"/configure.py
	sed -i -e 's/ANY \*/void */g' sip/qt/*.sip sip/qtnetwork/*.sip || die
}

my_configure() {
	addpredict ${QTDIR}/etc/settings

	local myconf="-d $(python_get_sitedir) \
			-b /usr/bin \
			-v /usr/share/sip \
			-n /usr/include \
			-o /usr/$(get_libdir) \
			-w -y qt-mt
			-u"
	use debug && myconf="${myconf} -u"

	"${PYTHON}" configure.py ${myconf} || die 'configure failed'
}

src_configure() {
	python_foreach_impl my_configure
}

src_compile() {
	python_foreach_impl emake
}

src_install() {
	python_foreach_impl make DESTDIR="${D}" install || die "install failed"
	dodoc ChangeLog NEWS README THANKS
	use doc && dohtml doc/PyQt.html
	if use examples ; then
		dodir /usr/share/doc/${PF}/examples
		cp -r examples3/* "${D}"/usr/share/doc/${PF}/examples
	fi
}
