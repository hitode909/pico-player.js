SRC_DIR = src
DST_DIR = dst

BUILD_DIR = build
JS_ENGINE ?= `which node nodejs 2>/dev/null`
COMPILER = ${JS_ENGINE} ${BUILD_DIR}/uglify.js --unsafe

MODULES = ${SRC_DIR}/pico-player.js


PICO_PLAYER     = ${DST_DIR}/pico-player.js
PICO_PLAYER_MIN = ${DST_DIR}/pico-player.min.js
PICO_PLAYER_VER = $(shell cat version.txt)
VERSION = sed "s/@VERSION/${PICO_PLAYER_VER}/"


all: core

core: pico-player min
	@@echo "pico-player.js build complete"

${DST_DIR}:
	@@mkdir -p ${DST_DIR}

pico-player: ${PICO_PLAYER}

${PICO_PLAYER}: ${MODULES} | ${DST_DIR}
	@@echo "Building" ${PICO_PLAYER}
	@@cat ${MODULES} | \
		${VERSION} > ${PICO_PLAYER}

min: pico-player ${PICO_PLAYER_MIN}

${PICO_PLAYER_MIN}: ${PICO_PLAYER}
	@@if test ! -z ${JS_ENGINE}; then \
		echo "Minifying pico-player.js" ${PICO_PLAYER_MIN}; \
		${COMPILER} ${PICO_PLAYER} > ${PICO_PLAYER_MIN}; \
	else \
		echo "You must have NodeJS installed in order to minify pico-player.js."; \
	fi
