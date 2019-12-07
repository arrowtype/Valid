VENV_DIR=.venv

all: static vf

# ------------------------------
# Clean targets
# ------------------------------

clean-venv:
	rm -rf "$(VENV_DIR)"

# ------------------------------
# Build targets
# ------------------------------

static vf:
	cd source && $(MAKE) $@

# ------------------------------
# Build dependency management
# ------------------------------
# setup creates a Python 3 virtual environment directory
setup:
	mkdir -p "$(VENV_DIR)"
	python3 -m venv "$(VENV_DIR)"
	"$(VENV_DIR)/bin/pip" install --upgrade pip
	"$(VENV_DIR)/bin/pip" install -r requirements.txt
	@echo "\n\nDependency versions installed in the venv are:\n"
	@$(MAKE) list-deps

# sync-deps syncs updated build dependencies in an existing virtual environment
# installing and uninstalling packages as (re)defined in the requirements.txt file
sync-deps:
	"$(VENV_DIR)/bin/pip" install -r requirements.txt

# list-deps displays venv installed dependencies
list-deps:
	@"$(VENV_DIR)/bin/pip" list

# [MAINTAINER ONLY TARGET]
# update-deps updates the requirements.txt file with new releases of Python build dependencies
# Note: the `pip-compile` tool is from the https://github.com/jazzband/pip-tools package
update-deps:
	pip-compile -U


# ------------------------------
# Test
# ------------------------------

test: test-fontbakery test-ftxvalidator


test-fontbakery: test-fontbakery-static-ttf test-fontbakery-static-otf test-fontbakery-variable-ttf

test-fontbakery-static-ttf:
	fontbakery check-universal --loglevel WARN build/Valid/static/*.ttf

test-fontbakery-static-otf:
	fontbakery check-universal --loglevel WARN build/Valid/static/*.otf

test-fontbakery-variable-ttf:
	fontbakery check-universal --loglevel WARN build/Valid/variable/*.ttf


test-ftxvalidator: test-ftxvalidator-static-ttf test-ftxvalidator-static-otf test-ftxvalidator-static-woff2 test-ftxvalidator-variable-ttf

test-ftxvalidator-static-ttf:
	ftxvalidator -t all build/Valid/static/*.ttf

test-ftxvalidator-static-otf:
	ftxvalidator -t all build/Valid/static/*.otf

test-ftxvalidator-static-woff2:
	ftxvalidator -t all build/Valid/static/*.woff2

test-ftxvalidator-variable-ttf:
	ftxvalidator -t all build/Valid/variable/*.ttf


.PHONY: all clean-venv list-deps setup static sync-deps test test-fontbakery test-ftxvalidator update-deps vf
