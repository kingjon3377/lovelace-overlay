# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..13} )

inherit python-any-r1 savedconfig

DESCRIPTION="Curated host file for malware blocking"
HOMEPAGE="https://github.com/StevenBlack/hosts"
SRC_URI="https://github.com/StevenBlack/hosts/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/hosts-${PV}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+savedconfig"

DEPEND="${RDEPEND}"
BDEPEND="${PYTHON_DEPS}
	$(python_gen_any_dep '
	                dev-python/requests[${PYTHON_USEDEP}]
	')"

python_check_deps() {
	python_has_version -b "dev-python/requests[${PYTHON_USEDEP}]"
}

pkg_setup() {
	python_setup
}

src_prepare() {
	default
	restore_config myhosts whitelist.txt blacklist.txt
}

src_compile() {
	local hostsconfig=(
		--auto
		--noupdate
		--skipstatichosts
	)
	test -s whitelist.txt && hostsconfig+=( --whitelist whitelist.txt ) || touch whitelist.txt
	test -s blacklist.txt && hostsconfig+=( --blacklist blacklist.txt ) || touch blacklist.txt
	test -s myhosts || touch myhosts
	hostsconfig+=( --extensions gambling porn )
	"${EPYTHON}" updateHostsFile.py "${hostsconfig[@]}" || die
	# TODO: Transform to also add '::' (IPv6) for each hostname as well as '0.0.0.0' (IPv4)
}

src_install() {
	insinto /etc
	local_hostname="${HOSTNAME}"
	if test -z "${local_hostname}";then
		ewarn "HOSTNAME variable not available in ebuild environment"
		local_hostname="$(hostname)"
	fi
	sed -i -e "s#@@HOSTNAME@@#${local_hostname}#" hosts || die
	doins hosts
	save_config myhosts whitelist.txt blacklist.txt
	dodoc myhosts.example whitelist.example blacklist.example
}
