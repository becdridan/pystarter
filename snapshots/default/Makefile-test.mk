.PHONY: check format pyright test integration test-all hooks

## format, lint and type check
check: export SKIP=test
check: hooks

## format and lint
format: export SKIP=pyright,test
format: hooks

## pyright type check
pyright: node_modules $(venv)
	node_modules/.bin/pyright

## run unit tests
test: $(venv)
	$(venv)/bin/pytest -m "not integration"

## run integration tests
integration: $(venv)
	$(venv)/bin/pytest -m "integration"

## run all tests
test-all: $(venv)
	$(venv)/bin/pytest

## run pre-commit git hooks on all files
hooks: node_modules $(venv)
	$(venv)/bin/pre-commit run --color=always --all-files --hook-stage push