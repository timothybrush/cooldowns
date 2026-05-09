.PHONY: docs lint

docs:
	uv run --with zensical zensical serve

lint:
	shellcheck cooldowns.sh
	uv run --with zensical zensical build
