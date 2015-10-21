# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

USE_RUBY="ruby19"

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

src_unpack() {
	ruby-ng_src_unpack
	cd all && mv -i ${P}.orig ${P} || die "fixing dir name failed"
}

src_prepare() {
	cd "${WORKDIR}"/all && epatch \
		"${FILESDIR}/01path.dpatch" \
		"${FILESDIR}/02svndocdiff.dpatch" \
		"${FILESDIR}/03cgipath.dpatch" \
		"${FILESDIR}/04ignorewhitespace.dpatch" \
		"${FILESDIR}/05wordwrap.dpatch"
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
