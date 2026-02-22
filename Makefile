.PHONY: install bootstrap lint security hooks precommit check

install:
	./install.sh

bootstrap:
	./bootstrap.sh

lint:
	bash -n bootstrap.sh
	bash -n install.sh

security:
	python3 scripts/security_scrub.py

hooks:
	pre-commit install

precommit:
	pre-commit run --all-files

check: lint security precommit
