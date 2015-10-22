# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4

inherit eutils autotools

MY_MAJOR_VERSION=12.10

DESCRIPTION="Run executables under a new DBus session for testing"
HOMEPAGE="https://launchpad.net/dbus-test-runner"
SRC_URI="http://launchpad.net/${PN}/${MY_MAJOR_VERSION}/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc x86"

IUSE="test"

RDEPEND="
	>=dev-libs/dbus-glib-0.98
	>=dev-libs/glib-2.34:2
"
DEPEND="
	${RDEPEND}
	dev-util/intltool
	test? ( >=dev-util/bustle-0.4 )
"

src_prepare() {
	epatch "${FILESDIR}/support-bustle-0.4.patch"
	# Drop -Werror usage
	sed -e 's/-Werror//' \
		-i libdbustest/Makefile.{am,in} \
		-i src/Makefile.{am,in} \
		-i tests/Makefile.{am,in} \
		|| die
	eautoreconf
}

src_test() {
	chmod +x "${S}/libdbustest/dbus-test-bustle-handler" "${S}/tests/test-bustle-data-check.0.4.sh" || die
	default_src_test
}
