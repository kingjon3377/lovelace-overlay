# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby21"

inherit eutils ruby-ng

DESCRIPTION="Compares two files word by word / char by char"
HOMEPAGE="http://www.kt.rim.or.jp/~hisashim/docdiff/"
SRC_URI="https://github.com/hisashim/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

each_ruby_prepare() {
	sed -i -e "s@^RUBY = ruby@RUBY = ${RUBY}@" Makefile || die
}

all_ruby_compile() {
	emake readme.en.html index.en.html
}

each_ruby_test() {
	emake test
}

each_ruby_install() {
	pushd lib > /dev/null || die
	doruby -r *
	popd > /dev/null || die
}

each_ruby_test() {
	emake test
}

all_ruby_install() {
	DESTDIR="${D}" PREFIX="/usr" emake install
	#dobin bin/*
	#doman "${FILESDIR}"/${PN}.1
	#insinto /etc/${PN} && newins ${PN}.conf.example ${PN}.conf
	#dohtml -r readme.html index.html img readme.en.html index.en.html
	#dodoc readme.md
	#dodoc -r sample
}
