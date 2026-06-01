.PHONY: docs lint smoke-test

docs:
	uv run --with zensical zensical serve

lint:
	shellcheck cooldowns.sh
	uv run --with mdlint mdlint check docs/index.md README.md
	uv run --with zensical zensical build

smoke-test:
	podman run --rm -i \
		-v ./cooldowns.sh:/usr/local/bin/cooldowns.sh:ro,z \
		quay.io/fedora/fedora:latest \
		bash -c 'dnf install -q -y nodejs24-npm python3-pip && pip install -q --upgrade pip poetry && bash -s /etc/profile.d/cooldowns.sh' \
		< tests/smoke-test.sh
