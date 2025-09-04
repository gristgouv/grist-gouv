# To run Grist:
#   Check out gristlabs/grist-core into the core subdirectory. Then,
#   make requirements
#   make build
#   GRIST_SESSION_SECRET=something make start
#
# To build gristlabs/grist-ee image:
#   make docker
#
# See core/Dockerfile for version hints. Node 10 or greater should
# work, with python 3.9 or greater (or python 2.7 if you are old-school).
# Will need yarn installed, and a recent version of docker to build a
# docker image.

default:
	@echo "To make and run Grist:"
	@echo "  make requirements"
	@echo "  make build"
	@echo "  GRIST_SESSION_SECRET=something make start"
	@echo ""
	@echo "To make a Grist image (does not require above steps):"
	@echo "  make docker"

requirements:
	test -e core || git clone https://github.com/gristlabs/grist-core.git core 
	test -e core/ext && echo core/ext present || ln -s ../ext core/ext
	yarn --cwd=ext install --frozen-lockfile --modules-folder=../node_modules
	yarn --cwd=core install --frozen-lockfile
	yarn --cwd=core run install:python

build:
	yarn --cwd=core run build

start:
	yarn --cwd=core start

docker:
	docker buildx build --load -t gristlabs/grist-ee --build-context=ext=ext core
