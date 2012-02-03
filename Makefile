SRC_DIR  = src
DIST_DIR = .

BUILD_DIR = build
JS_ENGINE ?= `which node nodejs 2>/dev/null`
COMPILER = ${JS_ENGINE} ${BUILD_DIR}/uglify.js --unsafe

PICO_PLAYER     = ${DIST_DIR}/pico-player.js
PICO_PLAYER_MIN = ${DIST_DIR}/pico-player.min.js

all:
	@@if test ! -z ${JS_ENGINE}; then \
		echo "Minifying pico-player.js" ${PICO_PLAYER_MIN}; \
		${COMPILER} ${PICO_PLAYER} > ${PICO_PLAYER_MIN}; \
	else \
		echo "You must have NodeJS installed in order to minify pico-player.js."; \
	fi
