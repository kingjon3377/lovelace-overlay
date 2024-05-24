# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_11 )

inherit git-r3 python-single-r1 edos2unix

DESCRIPTION="Simplistic AO3 CLI downloader"
HOMEPAGE="https://github.com/phthallo/ao3downloader"
EGIT_REPO_URI="https://github.com/phthallo/${PN}.git"

LICENSE="GPL-3"
SLOT="0"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		app-text/ao3-cli[${PYTHON_USEDEP}]')"

# TODO: Make more robust against absence of system config, and add per-user config support (from XDG dirs)
PATCHES=( "${FILESDIR}/system_config.patch" "${FILESDIR}/shebang.patch" )

src_prepare() {
	edos2unix *.py
	default
}

src_install() {
	insinto /etc/${PN}
	doins settings.json
	dodoc README.md
	python_newscript ${PN/er/}.py ${PN/er/}
}
