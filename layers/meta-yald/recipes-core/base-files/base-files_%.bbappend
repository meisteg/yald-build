FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

do_install:append () {
    install -m 0755 ${S}/share/dot.profile ${D}${ROOT_HOME}/.profile
    install -m 0755 ${S}/share/dot.bashrc ${D}${ROOT_HOME}/.bashrc
}
