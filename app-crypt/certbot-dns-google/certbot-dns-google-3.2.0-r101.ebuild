# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

PARENT_PN="certbot"
PARENT_P="${PARENT_PN}-${PV}"

if [[ "${PV}" == *9999 ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/certbot/certbot.git"
	EGIT_SUBMODULES=()
	EGIT_CHECKOUT_DIR="${WORKDIR}/${PARENT_P}"
else
	SRC_URI="
		https://github.com/certbot/certbot/archive/v${PV}.tar.gz
			-> ${PARENT_P}.gh.tar.gz
	"
	#KEYWORDS="~amd64 ~arm64 ~x86"
	# Currently limited to amd64 and x86 because of main package’s limitations.
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Google Cloud DNS Authenticator plugin for Certbot (Let’s Encrypt Client)"
HOMEPAGE="
	https://github.com/certbot/certbot
	https://pypi.org/project/certbot-dns-google/
	https://letsencrypt.org/
"

S="${WORKDIR}/${PARENT_P}/${PN}"
LICENSE="Apache-2.0"
SLOT="0"

BDEPEND="
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"

# See module’s setup.py for dependencies
RDEPEND="
	>=app-crypt/certbot-3.2.0-r101[${PYTHON_USEDEP}]
	>=dev-python/google-api-python-client-1.6.5[${PYTHON_USEDEP}]
	>=dev-python/google-auth-2.16.0[${PYTHON_USEDEP}]
"

distutils_enable_sphinx docs \
	dev-python/sphinx-rtd-theme
distutils_enable_tests pytest

python_test() {
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest
}
