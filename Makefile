SHELL=/bin/bash
BUILD_DIR=build

.PHONY: makedirs render-html copy-static all clean download-fonts

all: makedirs render-html copy-static

clean:
	rm -rv $(BUILD_DIR)

makedirs:
	mkdir -pv $(BUILD_DIR)/{third_party,img,fonts}

render-html:
	python3 scripts/build.py src/config.yaml src/index.template.html $(BUILD_DIR)/index.html

copy-static:
	cp -v node_modules/dom-to-image/dist/dom-to-image.min.js $(BUILD_DIR)/third_party/dom-to-image.min.js \
		&& cp -v src/error.html src/main.{js,css} $(BUILD_DIR) \
		&& cp -rv img fonts $(BUILD_DIR)

download-fonts:
	curl --location 'https://fonts.google.com/download?family=Roboto%20Slab' --output roboto-slab.zip \
		&& unzip roboto-slab.zip -d fonts \
		&& rm roboto-slab.zip
