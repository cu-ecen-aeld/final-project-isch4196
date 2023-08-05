SUMMARY = "Simple test"
SECTION = "examples"
LICENSE = "CLOSED"

SRC_URI = "file://test.c"

S = "${WORKDIR}"

DEPENDS += "pigpio"
# RDEPENDS:${PN} += "pigpio"

# Specifies architecture-specific C compiler flags for target system
TARGET_CC_ARCH += "${LDFLAGS}"

# Specifies flags to pass to linker when building for the target
TARGET_LDFLAGS += "-lpigpio"

do_compile() {
	     ${CC} test.c ${TARGET_LDFLAGS} -o my_simple_test
}

do_install() {
	     install -d ${D}${bindir}
	     install -m 0755 my_simple_test ${D}${bindir}
}

FILES:${PN} += "${bindir}/my_simple_test"
