# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit cmake-utils 

MY_P=ogs-mahjong-${PV}-src

DESCRIPTION="MJIN is a OGRE-based game engine library written by Opensource Game Studio."
HOMEPAGE="http://opengamestudio.org"
SRC_URI="http://sourceforge.net/projects/osrpgcreation/files/Mahjong/${PV}/${MY_P}.tar.bz2"

LICENSE="GPL3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND="media-libs/openal"
DEPEND="${RDEPEND}
	media-libs/alure[vorbis]
	net-misc/curl
	=dev-games/ois-1.2.0
	>=dev-games/ogre-1.8.0[freeimage]
	>=dev-games/cegui-0.7.6[ogre,tinyxml]"

S="${WORKDIR}/ogs-mahjong-${PV}-src/mjin"

src_configure() {
    cmake-utils_src_configure
}
