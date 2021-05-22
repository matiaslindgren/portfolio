SHELL := /bin/bash
BUILD_DIR := build

.PHONY: makedirs render-html copy-static all clean download-fonts

all: makedirs render-html copy-static

clean:
	@rm -rv $(BUILD_DIR)

makedirs:
	@mkdir -pv $(BUILD_DIR)/{img,fonts,demos}

render-html:
	@python3 scripts/build.py src/config.yaml src/index.template.html $(BUILD_DIR)/index.html
	@for demo_template in $$(find src/demos -type f -name '*.html.j2'); do \
		python3 scripts/build.py src/config.yaml $$demo_template $(BUILD_DIR)/demos/$$(basename -s .j2 $${demo_template}); \
	done

copy-static:
	@cp -v robots.txt src/{404.html,main.css} $(BUILD_DIR)
	@cp -rv img fonts $(BUILD_DIR)

download-fonts:
	@curl --location 'https://fonts.google.com/download?family=Roboto%20Slab' --output roboto-slab.zip
	@unzip roboto-slab.zip -d fonts
	@rm roboto-slab.zip

deploy:
	@if [[ -z "${FIREBASE_PROJECT_ID}" ]]; then echo FIREBASE_PROJECT_ID must be set && exit 1; fi
	@firebase login
	@firebase deploy --project ${FIREBASE_PROJECT_ID}
