# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit git-r3

DESCRIPTION="Rendered emoji from mobile platforms for use in Pidgin"
HOMEPAGE="https://github.com/stv0g/unicode-emoji"
EGIT_REPO_URI="https://github.com/stv0g/unicode-emoji.git"

LICENSE="Apache-2.0 CC-BY-4.0 OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

# TODO: build from source-TTFs using the included generator scripts

src_install() {
	dodoc README.md
	rm README.md
	for file in *;do
		if ! test -f "${file}/theme"; then
			ewarn "${file} subdirectory doesn't contain a theme file, skipping ..."
			continue
		fi
		dodir "/usr/share/pixmaps/pidgin/emotes/${file}"
		insinto "/usr/share/pixmaps/pidgin/emotes/${file}"
		doins "${file}"/*.png "${file}/theme"
	done
}
