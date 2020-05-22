test:
	TEST=True python -m unittest -v

build:
	python ./setup.py build

sdist:
	python ./setup.py sdist

upload: sdist
	scp dist/wmgraph-*.tar.gz wibas@packages.wibas.de:/srv/www/packages.ep.wibas.de/simple/wmgraph/

.PHONY: upload sdist test build

pypi:
	rm -rf dist
	python3 setup.py sdist
	python3 setup.py sdist bdist_wheel
	python3 -m twine upload --repository pypi dist/*

testpypi:
	rm -rf dist
	python3 setup.py sdist
	python3 setup.py sdist bdist_wheel
	python3 -m twine upload --repository testpypi --verbose dist/*
