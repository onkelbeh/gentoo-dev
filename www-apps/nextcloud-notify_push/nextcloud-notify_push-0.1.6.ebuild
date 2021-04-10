# Copyright 2017-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

CRATES="
addr2line-0.14.1
adler-1.0.1
ahash-0.4.7
ahash-0.6.3
ahash-0.7.0
aho-corasick-0.7.15
ansi_term-0.11.0
ansi_term-0.12.1
arrayvec-0.5.2
async-stream-0.3.0
async-stream-impl-0.3.0
async-trait-0.1.42
atoi-0.3.3
atoi-0.4.0
atty-0.2.14
autocfg-0.1.7
autocfg-1.0.1
backtrace-0.3.56
base-x-0.2.8
base64-0.12.3
base64-0.13.0
beef-0.5.0
bitflags-1.2.1
bitvec-0.19.4
block-buffer-0.7.3
block-buffer-0.9.0
block-padding-0.1.5
buf_redux-0.8.4
build_const-0.2.1
bumpalo-3.6.1
byte-tools-0.3.1
byteorder-1.4.2
bytes-1.0.1
cc-1.0.67
cfg-if-1.0.0
chrono-0.4.19
chunked_transfer-1.4.0
clap-2.33.3
color-eyre-0.5.10
color-spantrace-0.1.6
combine-4.5.2
const_fn-0.4.5
cookie-0.14.4
cookie_store-0.12.0
cpuid-bool-0.1.2
crc-1.8.1
crossbeam-channel-0.5.0
crossbeam-queue-0.3.1
crossbeam-utils-0.8.3
crypto-mac-0.10.0
dashmap-4.0.2
digest-0.8.1
digest-0.9.0
discard-1.0.4
dotenv-0.15.0
dtoa-0.4.7
either-1.6.1
encoding_rs-0.8.28
eyre-0.6.5
fake-simd-0.1.2
flexi_logger-0.17.1
fnv-1.0.7
form_urlencoded-1.0.1
funty-1.1.0
futures-0.3.13
futures-channel-0.3.13
futures-core-0.3.13
futures-executor-0.3.13
futures-io-0.3.13
futures-macro-0.3.13
futures-sink-0.3.13
futures-task-0.3.13
futures-util-0.3.13
generic-array-0.12.3
generic-array-0.14.4
getrandom-0.1.16
getrandom-0.2.2
gimli-0.23.0
glob-0.3.0
h2-0.3.0
hashbrown-0.9.1
hashlink-0.6.0
headers-0.3.3
headers-core-0.2.0
heck-0.3.2
hermit-abi-0.1.18
hex-0.4.2
hmac-0.10.1
http-0.2.3
http-auth-basic-0.1.2
http-body-0.4.0
httparse-1.3.5
httpdate-0.3.2
hyper-0.14.4
hyper-rustls-0.22.1
idna-0.2.2
indenter-0.3.3
indexmap-1.6.1
input_buffer-0.4.0
instant-0.1.9
ipnet-2.3.0
itoa-0.4.7
js-sys-0.3.47
lazy_static-1.4.0
lexical-core-0.7.5
libc-0.2.86
libm-0.2.1
libsqlite3-sys-0.20.1
lock_api-0.4.2
log-0.4.14
logos-0.12.0
logos-derive-0.12.0
maplit-1.0.2
matchers-0.0.1
matches-0.1.8
md-5-0.9.1
memchr-2.3.4
mime-0.3.16
mime_guess-2.0.3
mini-redis-0.4.0
miniz_oxide-0.4.4
mio-0.7.9
miow-0.3.6
multipart-0.17.1
nextcloud_appinfo-0.6.0
nom-6.1.2
ntapi-0.3.6
num-bigint-0.2.6
num-bigint-0.3.1
num-bigint-dig-0.6.1
num-integer-0.1.44
num-iter-0.1.42
num-traits-0.2.14
num_cpus-1.13.0
numtoa-0.1.0
object-0.23.0
once_cell-1.7.0
opaque-debug-0.2.3
opaque-debug-0.3.0
owo-colors-1.3.0
parking_lot-0.11.1
parking_lot_core-0.8.3
parse-display-0.4.1
parse-display-derive-0.4.1
pem-0.8.3
percent-encoding-2.1.0
peresil-0.3.0
php-literal-parser-0.2.5
pin-project-1.0.5
pin-project-internal-1.0.5
pin-project-lite-0.2.4
pin-utils-0.1.0
pkg-config-0.3.19
ppv-lite86-0.2.10
proc-macro-error-1.0.4
proc-macro-error-attr-1.0.4
proc-macro-hack-0.5.19
proc-macro-nested-0.1.7
proc-macro2-1.0.24
publicsuffix-1.5.6
qstring-0.7.2
quick-error-1.2.3
quote-1.0.9
radium-0.5.3
rand-0.7.3
rand-0.8.3
rand_chacha-0.2.2
rand_chacha-0.3.0
rand_core-0.5.1
rand_core-0.6.2
rand_hc-0.2.0
rand_hc-0.3.0
redis-0.20.0
redox_syscall-0.2.5
redox_termios-0.1.2
regex-1.4.3
regex-automata-0.1.9
regex-syntax-0.6.22
remove_dir_all-0.5.3
reqwest-0.11.1
rfc7239-0.1.0
ring-0.16.20
rsa-0.3.0
rustc-demangle-0.1.18
rustc_version-0.2.3
rustls-0.19.0
ryu-1.0.5
safemem-0.3.3
scoped-tls-1.0.0
scopeguard-1.1.0
sct-0.6.0
semver-0.10.0
semver-0.9.0
semver-parser-0.7.0
serde-1.0.123
serde_derive-1.0.123
serde_json-1.0.63
serde_urlencoded-0.7.0
sha-1-0.8.2
sha-1-0.9.4
sha1-0.6.0
sha2-0.9.3
sharded-slab-0.1.1
signal-hook-registry-1.3.0
simple_asn1-0.4.1
slab-0.4.2
smallvec-1.6.1
socket2-0.3.19
source-span-2.2.0
spin-0.5.2
sqlformat-0.1.5
sqlx-0.5.1
sqlx-core-0.5.1
sqlx-macros-0.5.1
sqlx-rt-0.3.0
standback-0.2.15
static_assertions-1.1.0
stdweb-0.4.20
stdweb-derive-0.5.3
stdweb-internal-macros-0.2.9
stdweb-internal-runtime-0.1.5
stringprep-0.1.2
strsim-0.8.0
structopt-0.3.21
structopt-derive-0.4.14
subtle-2.4.0
sxd-document-0.3.2
sxd-xpath-0.4.2
syn-1.0.60
synstructure-0.12.4
tap-1.0.1
tempfile-3.2.0
termion-1.5.6
textwrap-0.11.0
thiserror-1.0.24
thiserror-impl-1.0.24
thread_local-1.1.3
time-0.1.43
time-0.2.25
time-macros-0.1.1
time-macros-impl-0.1.1
tinyvec-1.1.1
tinyvec_macros-0.1.0
tokio-1.2.0
tokio-macros-1.1.0
tokio-rustls-0.22.0
tokio-stream-0.1.3
tokio-tungstenite-0.13.0
tokio-util-0.6.3
tower-service-0.3.1
tracing-0.1.25
tracing-attributes-0.1.13
tracing-core-0.1.17
tracing-error-0.1.2
tracing-futures-0.2.5
tracing-log-0.1.2
tracing-serde-0.1.2
tracing-subscriber-0.2.16
try-lock-0.2.3
tungstenite-0.12.0
tungstenite-0.13.0
twoway-0.1.8
typed-arena-1.7.0
typenum-1.12.0
uncased-0.9.4
unicase-2.6.0
unicode-bidi-0.3.4
unicode-normalization-0.1.17
unicode-segmentation-1.7.1
unicode-width-0.1.8
unicode-xid-0.2.1
unicode_categories-0.1.1
untrusted-0.7.1
ureq-1.5.4
url-2.2.1
utf-8-0.7.5
utf8-ranges-1.0.4
vcpkg-0.2.11
vec_map-0.8.2
version_check-0.9.2
want-0.3.0
warp-0.3.0
warp-real-ip-0.2.0
wasi-0.10.2+wasi-snapshot-preview1
wasi-0.9.0+wasi-snapshot-preview1
wasm-bindgen-0.2.70
wasm-bindgen-backend-0.2.70
wasm-bindgen-futures-0.4.20
wasm-bindgen-macro-0.2.70
wasm-bindgen-macro-support-0.2.70
wasm-bindgen-shared-0.2.70
web-sys-0.3.47
webpki-0.21.4
webpki-roots-0.21.0
whoami-1.1.0
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
winreg-0.7.0
wyz-0.2.0
xpath_reader-0.5.3
yansi-0.5.0
zeroize-1.2.0
zeroize_derive-1.0.1
"

inherit cargo systemd

DESCRIPTION="Push daemon for Nextcloud clients"
HOMEPAGE="https://github.com/nextcloud/notify_push"
SRC_URI="https://github.com/nextcloud/notify_push/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})"
LICENSE="MIT Apache-2.0 BSD GPL-3 ISC MPL-2.0"
SLOT="0"
KEYWORDS=""
RESTRICT="test"

RDEPEND="acct-group/nobody
	acct-user/nobody"

S="${WORKDIR}/notify_push-${PV}"

QA_FLAGS_IGNORED="usr/bin/${PN}"

src_install() {
	cargo_src_install
	einstalldocs

	# default name is too generic
	mv "${ED}/usr/bin/notify_push" "${ED}/usr/bin/${PN}" || die

	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	newinitd "${FILESDIR}"/${PN}.init ${PN}
	systemd_newunit "${FILESDIR}"/${PN}.service ${PN}.service

	# restrict access because conf.d entry could contain
	# database credentials
	fperms 0640 /etc/conf.d/${PN}
}
