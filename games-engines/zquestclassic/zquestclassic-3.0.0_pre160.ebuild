# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit cmake python-any-r1

PROJECT_PN='ZQuestClassic'
PROJECT_PV='3.0.0-prerelease.160+2026-02-08'

DESCRIPTION="A game engine for creating games similar to the original NES Zelda"
HOMEPAGE="
	https://zquestclassic.com/
	https://github.com/ZQuestClassic/ZQuestClassic
"
SRC_URI="
	https://github.com/ZQuestClassic/ZQuestClassic/archive/refs/tags/${PROJECT_PV}.tar.gz
		-> "${P}.gh.tar.gz"
"

S="${WORKDIR}/${PROJECT_PN}-${PROJECT_PV/+/-}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="reports"

PATCHES=(
)

BDEPEND="
	${PYTHON_DEPS}
"

REDEPEND="
	>=dev-cpp/nlohmann_json-3.11.3
	dev-cpp/tbb
	dev-libs/libfmt
	>=dev-libs/nativefiledialog-extended-1.2.0
	>=dev-libs/xxhash-0.8.2
	media-libs/allegro:5[dumb]
	>=media-libs/libpng-1.6.38
	media-libs/libpng-compat:1.2
	net-misc/curl
	sys-libs/zlib
	# TODO: https://github.com/mariusbancila/stduuid
	reports? {
		>=dev-libs/sentry-native-0.6.6
	}
"

src_configure() {
	local mycmakeargs=(
		-DWANT_ERROR_CHECKING=FALSE # TODO: improve quality of code and discard this option later
		-DWANT_GIT_HOOKS=OFF
		-DWANT_SENTRY=$(usex reports)
		-DZC_OFFICIAL=FALSE
		-DZC_VERSION="${PROJECT_PV}"
	)

	cmake_src_configure
}
