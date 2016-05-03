# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit perl-app

DESCRIPTION="Send event reminders by email"
HOMEPAGE="https://launchpad.net/email-reminder"
SRC_URI="https://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-perl/XML-DOM
	dev-perl/gtk2-perl
	dev-perl/Date-Manip
	dev-perl/Email-Valid
	dev-perl/Authen-SASL
	virtual/perl-MIME-Base64"
RDEPEND="${DEPEND}"

src_prepare() {
	default_src_prepare
	cat > email-reminder.cron << EOF
#!/bin/sh
COLLECT_SCRIPT=/usr/sbin/collect-reminders
SEND_SCRIPT=/usr/bin/send-reminders

# Comment out the following line to enable this job
exit 0

if [ -x "$COLLECT_SCRIPT" -a -x "$SEND_SCRIPT" ]; then
	$COLLECT_SCRIPT
	su - email-reminder -c $SEND_SCRIPT
fi
EOF
}

src_install() {
	emake DESTDIR="${D}" install
	insinto /etc/cron.daily
	doins email-reminder.cron
	keepdir /var/spool/email-reminder
	fperms 750 /var/spool/email-reminder
	domenu *.desktop
	insinto /etc
	doins examples/email-reminder.conf
	dodoc examples/email-reminders
}

pkg_preinst() {
	enewgroup email-reminder
	enewuser email-reminder -1 -1 /var/spool/email-reminder email-reminder
	fowners email-reminder:email-reminder /var/spool/email-reminder
}
