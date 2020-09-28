# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI=https://gitorious.org/debian-packages/rolldice.git

inherit git-r3 toolchain-funcs

DESCRIPTION="virtual dice roller"
HOMEPAGE="https://packages.debian.org/rolldice"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	eapply debian/patches/*diff
	sed -i -e "s:/usr/games$:/usr/bin:" Makefile || die
	eapply_user
}

src_compile() {
	emake CC="$(tc-getCC) ${CFLAGS} ${LDFLAGS}"
}

DOCS=( README Changelog CREDITS )
