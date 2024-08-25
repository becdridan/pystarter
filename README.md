# Quickstart for typed Python

A minimal, generic, and opinionated template for typed ✨ python projects that includes:

* enforced type hints for non-test code because "explicit is better than implicit"
* pyright to check those type hints because it's more accurate and faster than mypy
* ruff for linting, formatting similar to black, import sorting, and auto fixing (eg: removing unused imports) because its the fastest and most feature complete solution
* pytest for tests because it doesn't require classes unlike unittest
* pre-commit to run the above on push, rather than commit, so your flow is interrupted less.
* pyproject.toml for describing requirements and python versions as per 621 (ie: no requirements.txt)
* a Makefile for development/CI. It creates a virtualenv in .venv/ and sets up your development environment ie: git hooks, formatters and linters. When the requirements in pyproject.toml change, the virtualenv is updated. No pipenv/poetry/conda required. Will use uv to install dependencies if present.
* a single virtualenv is assumed with a set of requirements for all packages, rather than a monorepo with multiple projects that have different requirements.
* a directory structure that prescribes packages at the top-level for convenience rather than under src/
* repo and package naming conventions (see Template parameters below)

## Project development prerequisites

Projects created using this template have [development prerequisites]({{cookiecutter.repo_name}}/CONTRIBUTING.md#Prerequisites). This includes node, which is required for pyright.

## Template parameters

The template will ask for the following:

- `repo_name`: The name of your repo. Repo names are lowered kebab-case, so hyphens rather than underscores, to be kind to humans.
- [`project_name`](https://peps.python.org/pep-0621/#name): The name of your project. This is used in _pyproject.toml_ and needed even if you aren't building a wheel or sdist.
- `package_name`: The name of your main python package. A python package is a group of modules, ie: a directory with _\_\_init\_\_.py_ file. Choose a short all-lowercase name without hyphens. The use of underscores is discouraged (see [PEP8](https://www.python.org/dev/peps/pep-0008/#package-and-module-names)).
- `description`: a one line description of your project.

## Pre-requisites

Install cruft using [pipx](https://github.com/pipxproject/pipx):

```
pipx install cruft
```

## Usage

```
cruft create 
# replace repo-name below with the name you specified during template creation
cd repo-name
git init && git commit -m 'root commit' --allow-empty
git add -A && git commit -m 'apply pystarter template'
make install
```

## About cruft

[Cruft](https://github.com/cruft/cruft) uses cookiecutter under the hood to bake a cookie. But unlike cookiecutter, cruft creates a _.cruft.json_ file which records the commit hash of the template used and the prompt values provided by the user at the time of baking. Projects baked using cruft can be aligned with future versions of the template by running `cruft update`. This does a 3-way merge to apply template changes made since baking.

## Contributing 🌱

Please do! See [CONTRIBUTING.md](CONTRIBUTING.md)