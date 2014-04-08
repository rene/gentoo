# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils

DESCRIPTION="Suite of simple-to-use utilities to apply compression techniques"
HOMEPAGE="http://www.complearn.org/"
SRC_URI="http://www.complearn.org/downloads/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="static-libs"

MAKEOPTS+=" -j1"

RDEPEND="dev-libs/libxml2
	sys-libs/zlib
	app-arch/bzip2
	>=dev-libs/glib-2.0.0
	sci-libs/gsl
	dev-libs/check"
DEPEND="dev-util/gob
	${RDEPEND}"

DOCS="NEWS README AUTHORS THANKS COPYING"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.1.7-fix_include.patch
}

src_configure() {
	econf --enable-shared \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc ${DOCS}
}
