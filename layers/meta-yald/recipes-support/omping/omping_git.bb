SUMMARY = "Omping (Open Multicast Ping) is tool to test IP multicast functionality primarily in local network."
HOMEPAGE = "https://github.com/jfriesse/omping"
SECTION = "net"
LICENSE = "0BSD"
LIC_FILES_CHKSUM = "file://COPYING;md5=169912ab7a9a7c467dfb20c86352e879"

SRC_URI = "git://github.com/jfriesse/omping;branch=master;protocol=https"
SRCREV = "e2aca77282ec802395a1eb76d9e23d08be8076c5"

S = "${WORKDIR}/git"

do_install() {
    oe_runmake 'DESTDIR=${D}' 'PREFIX=${prefix}' install
}
