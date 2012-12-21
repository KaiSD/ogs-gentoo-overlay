# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit cmake-utils 

MY_P=ogs-mahjong-${PV}-src

DESCRIPTION="OGS Mahjong is a simple mahjong solitaire game with nice 3D graphics and relaxing soundtrack."
HOMEPAGE="http://opengamestudio.org"
SRC_URI="http://sourceforge.net/projects/osrpgcreation/files/Mahjong/${PV}/${MY_P}.tar.bz2"

LICENSE="GPL3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="musicaddon editor"

RDEPEND="=games-board/ogs-mahjong-res-${PV}"
DEPEND="${RDEPEND}
	=dev-games/mjin-${PV}
	musicaddon? ( games-board/ogs-mahjong-music )
	editor? ( dev-python/PyQt4 )"

SDIR="${WORKDIR}/ogs-mahjong-${PV}-src"
BDIR="${WORKDIR}/ogs-mahjong-${PV}_build"
S="${SDIR}/mj"

src_configure() {
    cmake-utils_src_configure
}

src_install() {
dodir /usr/lib/ogs-mahjong
cp -R "${BDIR}/mj-bin" "${D}/usr/lib/ogs-mahjong/" || die "Install failed!"

dodir /usr/games/bin
echo "#!/bin/sh
/usr/lib/ogs-mahjong/mj-bin /usr/lib/OGRE/ /usr/share/ogs-mahjong/res/" >> "${D}/usr/games/bin/ogs-mahjong" || die "Install failed!"
chmod 755 "${D}/usr/games/bin/ogs-mahjong" || die "CHMOD failed"

sed 's/%PKG%/ogs-mahjong/g' "${SDIR}/mjbe/pkg/common/ogs-mahjong.desktop" | sed 's/usr\/games/usr\/games\/bin/g' > "${S}/ogs-mahjong.desktop"

doicon "${SDIR}/mjbe/pkg/common/ogs-mahjong.png"
domenu "${S}/ogs-mahjong.desktop"

if use editor ; then
	sed "s/uic.loadUi('UI\/editor.ui'/uic.loadUi('\/usr\/share\/ogs-mahjong-layour-editor\/UI\/editor.ui'/g" "${S}/tools/LayoutEditor/editor" |
	sed "s/uic.loadUi('UI\/new.ui'/uic.loadUi('\/usr\/share\/ogs-mahjong-layour-editor\/UI\/new.ui'/g" > "${D}/usr/games/bin/ogs-mahjong-layout-editor" || die "Editor install failed!"
	chmod 755 "${D}/usr/games/bin/ogs-mahjong-layout-editor" || die "CHMOD failed"
	
	dodir /usr/share/ogs-mahjong-layour-editor/
	cp -R "${S}/tools/LayoutEditor/UI" "${D}/usr/share/ogs-mahjong-layour-editor/" || die "Editor install failed!"
	sed 's/%PKG%/ogs-mahjong-layout-editor/g' "${SDIR}/mjbe/pkg/common/ogs-mahjong-layout-editor.desktop" | sed 's/usr\/games/usr\/games\/bin/g' > "${S}/ogs-mahjong-layout-editor.desktop"

	domenu "${S}/ogs-mahjong-layout-editor.desktop"
fi
}