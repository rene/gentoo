# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="qsearch complearn library"
HOMEPAGE="http://www.complearn.org/"
SRC_URI="http://www.complearn.org/downloads/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="static-libs"

MAKEOPTS+=" -j1"

RDEPEND="sci-libs/libcomplearn
	dev-libs/libxml2
	>=dev-libs/glib-2.0.0
	sci-libs/gsl"
DEPEND="${RDEPEND}"

DOCS="NEWS README AUTHORS COPYING"

src_configure() {
	econf
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc ${DOCS}
}
