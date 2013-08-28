# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="OGS Mahjong is a simple mahjong solitaire game with nice 3D graphics and relaxing soundtrack. This is a pack of additional audio tracks for the game."
HOMEPAGE="http://opengamestudio.org"
SRC_URI="http://sourceforge.net/projects/osrpgcreation/files/Mahjong/${PV}/ogs-mahjong-music-addon-${PV}.tar.lzma"

LICENSE="GPL3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

S="${WORKDIR}/res"

src_install() {
dodir /usr/share/ogs-mahjong
cp -R "${S}/" "${D}/usr/share/ogs-mahjong/" || die "Install failed!"
}
