APP =		nrf9160
ARCH =		arm

CC =		${CROSS_COMPILE}gcc
LD =		${CROSS_COMPILE}ld
OBJCOPY =	${CROSS_COMPILE}objcopy

LDSCRIPT =	${.CURDIR}/ldscript

OBJECTS =							\
		bsd_os.o					\
		main.o						\
		osfive/sys/arm/nordicsemi/nrf_uarte.o		\
		osfive/sys/arm/nordicsemi/nrf9160_power.o	\
		osfive/sys/arm/nordicsemi/nrf9160_spu.o		\
		osfive/sys/arm/nordicsemi/nrf9160_timer.o	\
		osfive/sys/arm/nordicsemi/nrf9160_uicr.o	\
		start.o

NRFXLIB =	${.CURDIR}/nrfxlib/

OBJECTS_LINK =		\
  ${NRFXLIB}/bsdlib/lib/cortex-m33/soft-float/libbsd_nrf9160_xxaa.a \
  ${NRFXLIB}/crypto/nrf_oberon/lib/cortex-m33/soft-float/liboberon_3.0.0.a

LIBRARIES = KERN ARM LIBC LIBAEABI MBEDTLS_MDSHA

CFLAGS =-mthumb -mcpu=cortex-m4 -g -nostdlib -nostdinc	\
	-fshort-enums					\
	-fno-builtin-printf -ffreestanding		\
	-Wredundant-decls -Wnested-externs		\
	-Wstrict-prototypes -Wmissing-prototypes	\
	-Wpointer-arith -Winline -Wcast-qual		\
	-Wundef -Wmissing-include-dirs -Wall -Werror

all:	__compile __link __info

clean:	__clean

.include "osfive/lib/kern/Makefile.inc"
.include "osfive/lib/libaeabi/Makefile.inc"
.include "osfive/lib/libc/Makefile.inc"
.include "osfive/lib/mbedtls/Makefile.inc"
.include "osfive/mk/bsd.mk"
