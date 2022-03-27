# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit perl-module python-r1 desktop

DESCRIPTION="Send event reminders by email"
HOMEPAGE="https://launchpad.net/email-reminder"
SRC_URI="https://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-perl/XML-DOM
	dev-perl/Gtk2
	dev-perl/Date-Manip
	dev-perl/Email-Valid
	dev-perl/Authen-SASL
	virtual/perl-MIME-Base64
	dev-python/pyside2[${PYTHON_USEDEP}]
	dev-python/defusedxml[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	acct-user/email-reminder"

src_configure() {
	perl-module_src_configure
}

src_compile() {
	emake
}

src_test() {
	# TODO: Add necessary deps and run 'emake -f Makefile.python test'
	emake test
}

src_install() {
	emake DESTDIR="${D}" install
	insinto /etc/cron.daily
	doins "${FILESDIR}/${PN}.cron"
	domenu *.desktop
	insinto /etc
	doins examples/email-reminder.conf
	dodoc examples/email-reminders
}
