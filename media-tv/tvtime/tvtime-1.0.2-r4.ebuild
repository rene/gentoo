# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils autotools

DESCRIPTION="High quality television application for use with video capture cards"
HOMEPAGE="http://tvtime.sourceforge.net/"
SRC_URI="http://www.renesp.com.br/files/gentoo/${P}-r4.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86"
IUSE="nls xinerama"

RDEPEND="x11-libs/libSM
	x11-libs/libICE
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXv
	x11-libs/libXxf86vm
	xinerama? ( x11-libs/libXinerama )
	x11-libs/libXtst
	x11-libs/libXau
	x11-libs/libXdmcp
	>=media-libs/freetype-2
	>=sys-libs/zlib-1.1.4
	>=media-libs/libpng-1.2
	>=dev-libs/libxml2-2.5.11
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	virtual/pkgconfig"

DOCS=( ChangeLog AUTHORS NEWS README )

src_prepare() {
	# patch the desktop file to remove deprecated values
	epatch "${FILESDIR}/${PN}-desktopfile.patch"

	# Rename the desktop file, bug #308297
	mv docs/net-tvtime.desktop docs/tvtime.desktop || die
	sed -i -e "s/net-tvtime.desktop/tvtime.desktop/g" docs/Makefile.am || die

	# use 'tvtime' for the application icon see bug #66293
	sed -i -e "s/tvtime.png/tvtime/" docs/tvtime.desktop || die

	# patch to adapt to PIC or __PIC__ for pic support
	epatch "${FILESDIR}"/${PN}-pic.patch #74227

	epatch "${FILESDIR}/${PN}-1.0.2-xinerama.patch"

	epatch "${FILESDIR}/${P}_p20110131-gettext.patch"
	epatch "${FILESDIR}/${PN}-libpng-1.5.patch"

	AT_M4DIR="m4" eautoreconf
}

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_with xinerama) || die "econf failed"
}

src_install() {
	default

	dohtml docs/html/*
}

pkg_postinst() {
	elog "A default setup for ${PN} has been saved as"
	elog "/etc/tvtime/tvtime.xml. You may need to modify it"
	elog "for your needs."
	elog
	elog "Detailed information on ${PN} setup can be"
	elog "found at ${HOMEPAGE}help.html"
	echo
}
