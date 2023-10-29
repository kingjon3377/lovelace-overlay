# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit perl-module desktop

DESCRIPTION="Send event reminders by email"
HOMEPAGE="https://launchpad.net/email-reminder"
SRC_URI="https://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-perl/XML-DOM
	dev-perl/Gtk2
	dev-perl/Date-Manip
	dev-perl/Email-Valid
	dev-perl/Authen-SASL
	virtual/perl-MIME-Base64"
RDEPEND="${DEPEND}
	acct-user/email-reminder"

src_configure() {
	perl-module_src_configure
}

src_install() {
	emake DESTDIR="${D}" install
	insinto /etc/cron.daily
	doins "${FILESDIR}/${PN}.cron"
	keepdir /var/spool/email-reminder
	fowners "${PN}" /var/spool/${PN}
	fperms 750 /var/spool/email-reminder
	domenu *.desktop
	insinto /etc
	doins examples/email-reminder.conf
	dodoc examples/email-reminders
}
