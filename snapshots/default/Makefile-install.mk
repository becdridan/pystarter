MAKEFLAGS += --warn-undefined-variables --check-symlink-times
SHELL = /bin/bash -o pipefail
.DEFAULT_GOAL := help
.PHONY: help clean install install-hooks

## display help message
help:
	@awk '/^##.*$$/,/^[~\/\.0-9a-zA-Z_-]+:/' $(MAKEFILE_LIST) | awk '!(NR%2){print $$0p}{p=$$0}' | awk 'BEGIN {FS = ":.*?##"}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' | sort

venv ?= .venv
# this is a symlink so we set the --check-symlink-times makeflag above
python := $(venv)/bin/python
# use uv if present, else fall back to pip
pip = $(shell command -v uv >/dev/null && echo "uv pip" || echo "$(venv)/bin/pip")

$(python): $(if $(value CI),|,) .python-version
# create venv using system python even when another venv is active
	PATH=$${PATH#$${VIRTUAL_ENV}/bin:} python3 -m venv --clear $(venv)
	$(python) --version
	$(pip) install --upgrade pip~=24.0

$(venv): $(if $(value CI),|,) pyproject.toml $(python)
	$(pip) install -e '.[dev]'
	touch $(venv)

node_modules: package.json
	npm install
	touch node_modules

# delete the venv
clean:
	rm -rf $(venv)

## create venv and install this package and hooks
install: $(venv) node_modules $(if $(value CI),,install-hooks)

install-hooks: .git/hooks/pre-push

.git/hooks/pre-push: $(venv)
	$(venv)/bin/pre-commit install --install-hooks -t pre-push