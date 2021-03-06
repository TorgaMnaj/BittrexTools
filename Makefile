#! /usr/bin/make -f
VENV        := $(CURDIR)/venv
PYTHON_BIN  ?= $(VENV)/bin/python3
PIP_BIN     ?= $(VENV)/bin/pip
APP			?= ./*.py

help:  		## This help dialog.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

bootstrap:  	## Bootstrap project or fix existing copy
	sudo apt update
	python3 -m venv venv
	$(PIP_BIN) install -r requirements.txt

upgradevenv:  	## Upgrade python3 virtualenv
	python3 -m venv --upgrade venv

run:  		## Start development version of application
	$(PYTHON_BIN) $(APP)

pyttests:  	## Run applications python tests
	chmod -R 755 ./*
	$(PYTHON_BIN) -m pytest pytests/
	bash ./.devbin/pylint.sh

commit:  	## Deploy, test, commit changes to git and push on github
	bash ./.devbin/bigcommit.sh
