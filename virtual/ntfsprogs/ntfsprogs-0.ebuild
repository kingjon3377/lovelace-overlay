# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="sys-fs/ntfsprogs has been replaced by part of ntfs-3g"
HOMEPAGE=""
SRC_URI=""

SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
#RDEPEND="|| ( sys-fs/ntfs3g[ntfsprogs] sys-fs/ntfsprogs )"
RDEPEND="sys-fs/ntfs3g[ntfsprogs]"
