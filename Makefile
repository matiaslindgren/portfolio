BUILD_DIR=build

.PHONY: dirs js html static all clean

all: dirs js html static

clean:
	rm -rv $(BUILD_DIR)

dirs:
	mkdir -pv $(BUILD_DIR)/third_party $(BUILD_DIR)/img

js:
	cp -v node_modules/dom-to-image/dist/dom-to-image.min.js $(BUILD_DIR)/third_party/dom-to-image.min.js

html:
	python3 scripts/build.py src/config.yaml src/index.template.html $(BUILD_DIR)/index.html

static:
	cp -rv img src/main.{js,css} $(BUILD_DIR)
