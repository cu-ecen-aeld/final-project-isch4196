SUMMARY = "Includes application code, hence app, of the balance bot"
LICENSE = "GPLv3"
LIC_FILES_CHKSUM = "file://LICENSE;md5=1ebbd3e34237af26da5dc08a4e440464"

SRC_URI = "git://git@github.com/isch4196/balbot.git;protocol=ssh;branch=master"
PV = "1.0+git${SRCPV}"
SRCREV = "87ea5a73940aefc918338241af08d51dbaa703e6"

S = "${WORKDIR}/git"

DEPENDS += "pigpio"
TARGET_CC_ARCH += "${LDFLAGS}"
TARGET_LDFLAGS += "-lpigpio"

do_install () {
	install -d ${D}${bindir}
	install -m 0755 ${S}/mpu6050_driver ${D}${bindir}	
}

FILES:${PN} += "${bindir}/mpu6050_driver"
