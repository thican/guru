# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="A free/open source, multi-platform BASIC compiler."
HOMEPAGE="https://www.freebasic.net"
SRC_URI="https://github.com/freebasic/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="FDL-1.2 GPL-2+ LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gpm libffi opengl X"

DEPEND="
	sys-libs/ncurses:=
	gpm? ( sys-libs/gpm )
	libffi? ( dev-libs/libffi )
	opengl? ( virtual/opengl )
	X? (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXpm
		x11-libs/libXrandr
		x11-libs/libXrender
	)
"
RDEPEND="${DEPEND}"
BDEPEND="|| (
		dev-lang/fbc
		dev-lang/fbc-bootstrap )"

DOCS="${S}/doc/fbc.1"

src_compile() {
	local xcflags=(
		$(usex gpm "" "-DDISABLE_GPM")
		$(usex libffi "" " -DDISABLE_FFI")
		$(usex opengl "" " -DDISABLE_OPENGL")
		$(usex X "" " -DDISABLE_X11")
	)

	local fbc="fbc"
	local fbcflags=""
	# fbc requires a space after the -Wl option
	# Additionally, this includes a stupid attempt to avoid a false
	# positive in bug 901169.
	local fblflags="$(echo "$LDFLAGS" | sed 's/-Wl,\([^ ]*\)/-Wl \1,/g')"

	if has_version -b dev-lang/fbc-bootstrap; then
		fbc="fbc-bootstrap"
		fbcflags="-prefix ${EPREFIX}/usr/share/freebasic-bootstrap"
		fblflags+=" -prefix ${EPREFIX}/usr/share/freebasic-bootstrap"
	fi

	# Build fbc
	emake AR="$(tc-getAR)" AS="$(tc-getAS)" CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} ${xcflags[*]} -I/usr/$(get_libdir)/libffi/include" \
		FBC="${fbc}" FBCFLAGS="${fbcflags}" FBLFLAGS="${fblflags}" TARGET="${CHOST}" V=1
}

src_install() {
	emake DESTDIR="${D}" prefix="${EPREFIX}/usr" TARGET="${CHOST}" install
	einstalldocs
}
