# firewalld requires shlex, which is in the python3-shell package.
# This was missing in the production image.
RDEPENDS:${PN} += "\
    python3-shell \
"
