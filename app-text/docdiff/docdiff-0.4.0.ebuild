# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

USE_RUBY="ruby21"

inherit eutils ruby-ng

DESCRIPTION="Compares two files word by word / char by char"
HOMEPAGE="http://www.kt.rim.or.jp/~hisashim/docdiff/"
SRC_URI="mirror://debian/pool/main/d/${PN}/${P/-/_}.orig.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

each_ruby_prepare() {
	sed -i -e "s@^RUBY = ruby@RUBY = ${RUBY}@" Makefile || die
}

RUBY_PATCHES=(
		"${FILESDIR}/01svn-r196.dpatch"
		"${FILESDIR}/02svndocdiff.dpatch"
		"${FILESDIR}/03cgipath.dpatch"
)

each_ruby_test() {
	emake test
}

each_ruby_install() {
	doruby -r "${WORKDIR}/all/${P}/docdiff"
}

all_ruby_install() {
	newbin ${PN}.rb ${PN}
	doman "${FILESDIR}"/${PN}.1
	insinto /etc/${PN} && newins ${PN}.conf.example ${PN}.conf
	dohtml readme.en.html
}
