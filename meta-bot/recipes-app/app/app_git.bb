SUMMARY = "Includes application code, hence app, of the balance bot"
LICENSE = "GPLv3"
LIC_FILES_CHKSUM = "file://LICENSE;md5=1ebbd3e34237af26da5dc08a4e440464"

SRC_URI = "gitsm://git@github.com/isch4196/balbot.git;protocol=ssh;branch=dev \
	  file://wifi_init.sh \
	  "
PV = "1.0+git${SRCPV}"
SRCREV = "304229c8722af845c75a20cdc2fb9ce6e9a45601"

S = "${WORKDIR}/git"

inherit update-rc.d
INITSCRIPT_PACKAGES = "${PN}"
INITSCRIPT_NAME:${PN} = "wifi_init.sh"

DEPENDS += "pigpio"
TARGET_CC_ARCH += "${LDFLAGS}"
TARGET_LDFLAGS += "-lpigpio -lm"

do_install () {
	install -d ${D}${bindir}
	install -m 0755 ${S}/balbot ${D}${bindir}

	install -d ${D}${sysconfdir}/init.d
	install -m 0755 ${WORKDIR}/wifi_init.sh ${D}${sysconfdir}/init.d
}

FILES:${PN} += " \
	       ${bindir}/balbot \
 	       ${sysconfdir}/init.d/wifi_init.sh \
	       "

