# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.24.2
	adler2@2.0.0
	adler@1.0.2
	aho-corasick@1.1.3
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstyle@1.0.10
	anyhow@1.0.86
	arc-swap@1.7.1
	arrayref@0.3.7
	arrayvec@0.7.4
	as_variant@1.2.0
	assign@1.1.1
	async-trait@0.1.88
	atomic-waker@1.1.2
	atomic@0.6.0
	autocfg@1.4.0
	axum-core@0.4.5
	axum-extra@0.9.6
	axum-server@0.6.0
	axum@0.7.9
	backtrace@0.3.74
	base64@0.21.7
	base64@0.22.1
	base64ct@1.6.0
	bindgen@0.69.5
	bitflags@1.3.2
	bitflags@2.9.0
	blake2b_simd@1.0.2
	block-buffer@0.10.4
	bumpalo@3.17.0
	bytemuck@1.22.0
	byteorder-lite@0.1.0
	byteorder@1.5.0
	bytes@1.10.1
	bytesize@2.0.1
	bzip2-sys@0.1.11+1.0.8
	cc@1.2.21
	cexpr@0.6.0
	cfg-if@1.0.0
	cfg_aliases@0.2.1
	chrono@0.4.40
	clang-sys@1.8.1
	clap@4.5.37
	clap_builder@4.5.37
	clap_derive@4.5.32
	clap_lex@0.7.4
	color_quant@1.1.0
	const-oid@0.9.6
	const_panic@0.2.8
	constant_time_eq@0.3.0
	core-foundation-sys@0.8.6
	core-foundation@0.9.4
	cpufeatures@0.2.12
	crc32fast@1.4.2
	critical-section@1.2.0
	crossbeam-channel@0.5.13
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.20
	crypto-common@0.1.6
	curve25519-dalek-derive@0.1.1
	curve25519-dalek@4.1.2
	data-encoding@2.6.0
	date_header@1.0.5
	der@0.7.9
	deranged@0.4.0
	digest@0.10.7
	directories@6.0.0
	dirs-sys@0.5.0
	displaydoc@0.2.5
	ed25519-dalek@2.1.1
	ed25519@2.2.3
	either@1.12.0
	encoding_rs@0.8.35
	enum-as-inner@0.6.0
	equivalent@1.0.2
	fallible-iterator@0.3.0
	fallible-streaming-iterator@0.1.9
	fastrand@2.3.0
	fdeflate@0.3.4
	fiat-crypto@0.2.9
	figment@0.10.19
	flate2@1.0.30
	fnv@1.0.7
	foldhash@0.1.5
	form_urlencoded@1.2.1
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-executor@0.3.31
	futures-io@0.3.31
	futures-macro@0.3.31
	futures-sink@0.3.31
	futures-task@0.3.31
	futures-util@0.3.31
	generator@0.8.4
	generic-array@0.14.7
	getrandom@0.2.16
	getrandom@0.3.2
	gif@0.13.1
	gimli@0.31.1
	glob@0.3.2
	h2@0.4.8
	hashbrown@0.12.3
	hashbrown@0.15.3
	hashlink@0.10.0
	headers-core@0.3.0
	headers@0.4.0
	heck@0.4.1
	heck@0.5.0
	hermit-abi@0.3.9
	hex@0.4.3
	hickory-proto@0.25.2
	hickory-resolver@0.25.2
	hmac@0.12.1
	hostname@0.3.1
	http-auth@0.1.9
	http-body-util@0.1.1
	http-body@1.0.1
	http@1.3.1
	httparse@1.10.1
	httpdate@1.0.3
	humantime-serde@1.1.1
	humantime@2.2.0
	hyper-rustls@0.26.0
	hyper-timeout@0.5.1
	hyper-util@0.1.5
	hyper@1.6.0
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.63
	icu_collections@2.0.0
	icu_locale_core@2.0.0
	icu_normalizer@2.0.0
	icu_normalizer_data@2.0.0
	icu_properties@2.0.0
	icu_properties_data@2.0.0
	icu_provider@2.0.0
	idna@1.0.3
	idna_adapter@1.2.1
	image-webp@0.1.3
	image@0.25.1
	indexmap@1.9.3
	indexmap@2.9.0
	inlinable_string@0.1.15
	ipconfig@0.3.2
	ipnet@2.9.0
	itertools@0.12.1
	itoa@1.0.15
	jobserver@0.1.33
	js-sys@0.3.74
	js_int@0.2.2
	js_option@0.1.1
	jsonwebtoken@9.3.1
	konst@0.3.9
	konst_kernel@0.3.9
	lazy_static@1.5.0
	lazycell@1.3.0
	libc@0.2.172
	libloading@0.8.3
	libredox@0.1.3
	libsqlite3-sys@0.33.0
	libz-sys@1.1.18
	linked-hash-map@0.5.6
	litemap@0.8.0
	lock_api@0.4.12
	log@0.4.27
	loom@0.7.2
	lru-cache@0.1.2
	lz4-sys@1.11.1+lz4-1.10.0
	maplit@1.0.2
	match_cfg@0.1.0
	matchers@0.1.0
	matchit@0.7.3
	memchr@2.7.4
	mime@0.3.17
	minimal-lexical@0.2.1
	miniz_oxide@0.7.4
	miniz_oxide@0.8.8
	mio@1.0.3
	moka@0.12.10
	multer@3.1.0
	nix@0.30.1
	nom@7.1.3
	nu-ansi-term@0.46.0
	num-bigint@0.4.6
	num-conv@0.1.0
	num-integer@0.1.46
	num-traits@0.2.19
	num_cpus@1.16.0
	object@0.36.7
	once_cell@1.21.3
	openssl-probe@0.1.5
	opentelemetry-http@0.29.0
	opentelemetry-jaeger-propagator@0.29.0
	opentelemetry-otlp@0.29.0
	opentelemetry-proto@0.29.0
	opentelemetry@0.29.1
	opentelemetry_sdk@0.29.0
	option-ext@0.2.0
	overload@0.1.1
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	pear@0.2.9
	pear_codegen@0.2.9
	pem@3.0.4
	percent-encoding@2.3.1
	pin-project-internal@1.1.5
	pin-project-lite@0.2.16
	pin-project@1.1.5
	pin-utils@0.1.0
	pkcs8@0.10.2
	pkg-config@0.3.32
	platforms@3.4.0
	png@0.17.13
	portable-atomic@1.11.0
	potential_utf@0.1.2
	powerfmt@0.2.0
	ppv-lite86@0.2.21
	proc-macro-crate@3.1.0
	proc-macro2-diagnostics@0.10.1
	proc-macro2@1.0.95
	prost-derive@0.13.5
	prost@0.13.5
	quick-error@1.2.3
	quick-error@2.0.1
	quote@1.0.40
	r-efi@5.2.0
	rand@0.8.5
	rand@0.9.1
	rand_chacha@0.3.1
	rand_chacha@0.9.0
	rand_core@0.6.4
	rand_core@0.9.3
	redox_syscall@0.5.7
	redox_users@0.5.0
	regex-automata@0.1.10
	regex-automata@0.4.9
	regex-syntax@0.6.29
	regex-syntax@0.8.5
	regex@1.11.1
	reqwest@0.12.4
	resolv-conf@0.7.0
	ring@0.17.14
	rusqlite@0.35.0
	rust-argon2@2.1.0
	rust-librocksdb-sys@0.37.0+10.2.1
	rust-rocksdb@0.41.0
	rustc-demangle@0.1.24
	rustc-hash@1.1.0
	rustc_version@0.4.0
	rustls-native-certs@0.7.0
	rustls-pemfile@2.1.2
	rustls-pki-types@1.12.0
	rustls-webpki@0.101.7
	rustls-webpki@0.102.4
	rustls@0.21.12
	rustls@0.22.4
	rustversion@1.0.17
	ryu@1.0.20
	schannel@0.1.23
	scoped-tls@1.0.1
	scopeguard@1.2.0
	sct@0.7.1
	sd-notify@0.4.5
	security-framework-sys@2.11.0
	security-framework@2.11.0
	semver@1.0.23
	serde@1.0.219
	serde_derive@1.0.219
	serde_html_form@0.2.7
	serde_json@1.0.140
	serde_path_to_error@0.1.16
	serde_spanned@0.6.8
	serde_urlencoded@0.7.1
	serde_yaml@0.9.34+deprecated
	sha-1@0.10.1
	sha1@0.10.6
	sha2@0.10.8
	sharded-slab@0.1.7
	shlex@1.3.0
	signal-hook-registry@1.4.5
	signature@2.2.0
	simd-adler32@0.3.7
	simple_asn1@0.6.2
	slab@0.4.9
	smallvec@1.15.0
	socket2@0.5.9
	spin@0.9.8
	spki@0.7.3
	stable_deref_trait@1.2.0
	subslice@0.2.3
	subtle@2.5.0
	syn@2.0.101
	sync_wrapper@0.1.2
	sync_wrapper@1.0.1
	synstructure@0.13.2
	tagptr@0.2.0
	thiserror-impl@1.0.69
	thiserror-impl@2.0.12
	thiserror@1.0.69
	thiserror@2.0.12
	thread_local@1.1.8
	threadpool@1.8.1
	tikv-jemalloc-sys@0.6.0+5.3.0-1-ge13ca993e8ccb9ba9847cc330696e02839f328f7
	tikv-jemallocator@0.6.0
	time-core@0.1.4
	time-macros@0.2.22
	time@0.3.41
	tinystr@0.8.1
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tokio-macros@2.5.0
	tokio-rustls@0.24.1
	tokio-rustls@0.25.0
	tokio-socks@0.5.1
	tokio-stream@0.1.17
	tokio-util@0.7.15
	tokio@1.45.0
	toml@0.8.22
	toml_datetime@0.6.9
	toml_edit@0.21.1
	toml_edit@0.22.26
	toml_write@0.1.1
	tonic@0.12.3
	tower-http@0.5.2
	tower-layer@0.3.3
	tower-service@0.3.3
	tower@0.4.13
	tower@0.5.2
	tracing-attributes@0.1.28
	tracing-core@0.1.33
	tracing-flame@0.2.0
	tracing-log@0.2.0
	tracing-opentelemetry@0.30.0
	tracing-subscriber@0.3.19
	tracing@0.1.41
	try-lock@0.2.5
	typenum@1.17.0
	typewit@1.9.0
	typewit_proc_macros@1.8.1
	uncased@0.9.10
	unicode-ident@1.0.18
	unsafe-libyaml@0.2.11
	untrusted@0.9.0
	url@2.5.4
	utf8_iter@1.0.4
	uuid@1.8.0
	valuable@0.1.0
	vcpkg@0.2.15
	version_check@0.9.5
	want@0.3.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasi@0.14.2+wasi-0.2.4
	wasm-bindgen-backend@0.2.97
	wasm-bindgen-futures@0.4.42
	wasm-bindgen-macro-support@0.2.97
	wasm-bindgen-macro@0.2.97
	wasm-bindgen-shared@0.2.97
	wasm-bindgen@0.2.97
	web-sys@0.3.69
	web-time@1.1.0
	weezl@0.1.8
	widestring@1.1.0
	wildmatch@2.3.4
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.58.0
	windows-core@0.61.0
	windows-implement@0.58.0
	windows-implement@0.60.0
	windows-interface@0.58.0
	windows-interface@0.59.1
	windows-link@0.1.1
	windows-result@0.2.0
	windows-result@0.3.2
	windows-strings@0.1.0
	windows-strings@0.4.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows@0.58.0
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
	winnow@0.5.40
	winnow@0.7.10
	winreg@0.50.0
	winreg@0.52.0
	wit-bindgen-rt@0.39.0
	writeable@0.6.1
	yansi@1.0.1
	yoke-derive@0.8.0
	yoke@0.8.0
	zerocopy-derive@0.8.25
	zerocopy@0.8.25
	zerofrom-derive@0.1.6
	zerofrom@0.1.6
	zeroize@1.8.1
	zerotrie@0.2.2
	zerovec-derive@0.11.1
	zerovec@0.11.2
	zstd-sys@2.0.10+zstd.1.5.6
	zune-core@0.4.12
	zune-jpeg@0.4.11
"

declare -A GIT_CRATES=(
	[ruma-appservice-api]='https://github.com/ruma/ruma;469a185332d109b227351bf39544732da05aded7;ruma-%commit%/crates/ruma-appservice-api'
	[ruma-client-api]='https://github.com/ruma/ruma;469a185332d109b227351bf39544732da05aded7;ruma-%commit%/crates/ruma-client-api'
	[ruma-common]='https://github.com/ruma/ruma;469a185332d109b227351bf39544732da05aded7;ruma-%commit%/crates/ruma-common'
	[ruma-events]='https://github.com/ruma/ruma;469a185332d109b227351bf39544732da05aded7;ruma-%commit%/crates/ruma-events'
	[ruma-federation-api]='https://github.com/ruma/ruma;469a185332d109b227351bf39544732da05aded7;ruma-%commit%/crates/ruma-federation-api'
	[ruma-identifiers-validation]='https://github.com/ruma/ruma;469a185332d109b227351bf39544732da05aded7;ruma-%commit%/crates/ruma-identifiers-validation'
	[ruma-macros]='https://github.com/ruma/ruma;469a185332d109b227351bf39544732da05aded7;ruma-%commit%/crates/ruma-macros'
	[ruma-push-gateway-api]='https://github.com/ruma/ruma;469a185332d109b227351bf39544732da05aded7;ruma-%commit%/crates/ruma-push-gateway-api'
	[ruma-signatures]='https://github.com/ruma/ruma;469a185332d109b227351bf39544732da05aded7;ruma-%commit%/crates/ruma-signatures'
	[ruma-state-res]='https://github.com/ruma/ruma;469a185332d109b227351bf39544732da05aded7;ruma-%commit%/crates/ruma-state-res'
	[ruma]='https://github.com/ruma/ruma;469a185332d109b227351bf39544732da05aded7;ruma-%commit%/crates/ruma'
)

LLVM_COMPAT=( {15..20} )
RUST_MIN_VER="1.83.0"

inherit cargo llvm-r2 systemd

MY_P="${PN}-v${PV}"
DESCRIPTION="Matrix homeserver written in Rust"
HOMEPAGE="
	https://conduit.rs
	https://gitlab.com/famedly/conduit
"
SRC_URI="https://gitlab.com/famedly/${PN}/-/archive/v${PV}/${MY_P}.tar.bz2
	${CARGO_CRATE_URIS}
"
S="${WORKDIR}/${MY_P}"

LICENSE="Apache-2.0"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD-2 BSD ISC MIT MPL-2.0 Unicode-3.0 ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="jemalloc rocksdb sqlite system-rocksdb"

# Libraries that can't be unbundled right now:
#	- app-arch/bzip2 ("rust-librocksdb-sys" pulls "bzip-sys[static]")
#	- app-arch/lz4 ("lz4-sys" crate doesn't look for system library... ironic)
#	- sys-libs/zlib ("rust-librocksdb-sys" pulls "libz-sys[static]")
COMMON_DEPEND="
	jemalloc? ( dev-libs/jemalloc:= )
	rocksdb? (
		app-arch/snappy:=
		app-arch/zstd:=
		system-rocksdb? (
			dev-libs/rocksdb
		)
	)
	sqlite? ( dev-db/sqlite:3 )
"
RDEPEND="${COMMON_DEPEND}
	acct-user/conduit
	app-misc/ca-certificates
"
# clang needed for bindgen
DEPEND="${COMMON_DEPEND}
	rocksdb? (
		$(llvm_gen_dep '
			llvm-core/clang:${LLVM_SLOT}
			llvm-core/llvm:${LLVM_SLOT}
		')
	)
"
BDEPEND="virtual/pkgconfig"

DOCS=( {APPSERVICES,CODE_OF_CONDUCT,DEPLOY,README,TURN}.md )

QA_FLAGS_IGNORED="usr/bin/${PN}"

pkg_setup() {
	use rocksdb && llvm-r2_pkg_setup
	rust_pkg_setup
}

src_configure() {
	# * Tracker bug for "*-sys" crates that build C code:
	# https://bugs.gentoo.org/709568
	# * Gentoo Wiki articles with tips and tricks:
	# https://wiki.gentoo.org/wiki/Project:Rust/sys_crates
	# https://wiki.gentoo.org/wiki/Writing_Rust_ebuilds#Unbundling_C_libraries
	export PKG_CONFIG_ALLOW_CROSS=1
	export LIBSQLITE3_SYS_USE_PKG_CONFIG=1
	export ZSTD_SYS_USE_PKG_CONFIG=1
	export SNAPPY_LIB_DIR="${ESYSROOT}/usr/$(get_libdir)"
	export JEMALLOC_OVERRIDE="${ESYSROOT}/usr/$(get_libdir)/libjemalloc.so"

	if use system-rocksdb; then
		export ROCKSDB_INCLUDE_DIR="${ESYSROOT}/usr/include"
		export ROCKSDB_LIB_DIR="${ESYSROOT}/usr/$(get_libdir)"
	fi

	local myfeatures=(
		conduit_bin
		systemd
		$(usev jemalloc)

		# database backends
		$(usex sqlite backend_sqlite '')
		$(usex rocksdb backend_rocksdb '')
	)

	cargo_src_configure --no-default-features
}

src_install() {
	cargo_src_install

	keepdir /var/lib/matrix-conduit
	fowners conduit:conduit /var/lib/matrix-conduit
	fperms 750 /var/lib/matrix-conduit

	insinto /etc/conduit
	newins conduit-example.toml conduit.toml

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/conduit.logrotate conduit

	newinitd "${FILESDIR}"/conduit.initd-r1 conduit
	newconfd "${FILESDIR}"/conduit.confd conduit
	systemd_newunit "${FILESDIR}"/conduit.service-r1 conduit.service
}
