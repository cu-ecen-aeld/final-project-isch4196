SUMMARY = "Raspberry Pi GPIO module"
HOMEPAGE = "http://abyz.me.uk/rpi/pigpio/python.html"
LICENSE = "Unlicense"
LIC_FILES_CHKSUM = "file://UNLICENCE;md5=61287f92700ec1bdf13bc86d8228cd13"

SRC_URI = "git://github.com/joan2937/pigpio;protocol=https;branch=master"
#	  file://pigpio.sh"
PV = "1.78+git${SRCPV}"
SRCREV = "c33738a320a3e28824af7807edafda440952c05d"

S = "${WORKDIR}/git"

inherit setuptools3-base cmake 
#update-rc.d

# Documentation related files. All documentation is separated into it's own
# package so that it does not need to be installed unless explicitly required.
FILES:${PN}-doc += "\
     /usr/man \
     /usr/man/man3 \
     /usr/man/man1 \
     /usr/man/man3/pigpiod_if.3 \
     /usr/man/man3/pigpiod_if2.3 \
     /usr/man/man3/pigpio.3 \
     /usr/man/man1/pigpiod.1 \
     /usr/man/man1/pig2vcd.1 \
     /usr/man/man1/pigs.1 \
"

# To correct "-dev package pigpio-dev contains non-symlink .so
# '/usr/lib/libpigpiod_if.so'" error.
# SOLIBS matches real shared object libraries, SOLIBSDEV matches the development
# form (unversioned symlink). They respectively put the libraries into
# FILES:${PN} and FILES:${PN}-dev.
# https://docs.yoctoproject.org/dev/dev-manual/prebuilt-libraries.html
SOLIBS = ".so"
FILES_SOLIBSDEV = ""

# FILES:${PN} += "\
# 	    ${sysconfdir}/init.d/pigpio.sh \
# 	    "
#
# INITSCRIPT_PACKAGES = "${PN}"
# INITSCRIPT_NAME:${PN} = "pigpio.sh"
# INITSCRIPT_PARAMS = "start 01 5 3 2 . stop 99 0 1 6."

do_install() {
    # cmake already installs files into correct directory, just need install directory
    install -d ${D}${bindir}
    install -d ${D}${libdir}

    # startup script
    # install -d ${D}${sysconfdir}/init.d
    # install -m 0755 ${WORKDIR}/pigpio.sh ${D}${sysconfdir}/init.d
    
    cmake_do_install
}