# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_BUILDER="sphinx"
DOCS_AUTODOC=0
DOCS_DIR="docs"
PYTHON_COMPAT=( python3_{11..13} )
inherit python-any-r1 docs nim-utils

DESCRIPTION="Packaging-friendly Nim build system"
HOMEPAGE="
	https://nimbus.sysrq.in/
	https://git.sysrq.in/nimbus/about/
"
if [[ ${PV} == 9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sysrq.in/nimbus.git"
else
	SRC_URI="https://git.sr.ht/~cyber/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0 BSD"
SLOT="0"
IUSE="debug"

RDEPEND="dev-lang/nim"
BDEPEND="
	${RDEPEND}
	doc? (
		$(python_gen_any_dep '
			dev-python/insipid-sphinx-theme[${PYTHON_USEDEP}]
			dev-python/sphinx-prompt[${PYTHON_USEDEP}]
		')
	)
"

python_check_deps() {
	use doc || return 0

	python_has_version "dev-python/insipid-sphinx-theme[${PYTHON_USEDEP}]" &&
	python_has_version "dev-python/sphinx-prompt[${PYTHON_USEDEP}]"
}

src_configure() {
	nim_gen_config
}

src_compile() {
	enim c src/nimbus
	enim c src/txt2deps

	docs_compile
}

src_test() {
	etestament pattern 'tests/**/**/test*.nim'
}

src_install() {
	dobin src/nimbus
	dobin src/txt2deps

	doman man/*.1
	einstalldocs
}
