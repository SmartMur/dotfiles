.PHONY: install bootstrap lint security check

install:
	./install.sh

bootstrap:
	./bootstrap.sh

lint:
	bash -n bootstrap.sh
	bash -n install.sh

security:
	python3 scripts/security_scrub.py

check: lint security
