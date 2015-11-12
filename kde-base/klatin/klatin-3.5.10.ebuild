# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI=5
KMNAME=kdeedu
inherit kde-meta

DESCRIPTION="KDE: KLatin - a program to help revise Latin"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=">=kde-base/libkdeedu-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libkdeedu/kdeeducore"
KMCOPYLIB="libkdeeducore libkdeedu/kdeeducore"
