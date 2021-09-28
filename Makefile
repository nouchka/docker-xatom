DOCKER_IMAGE=xatom

include Makefile.docker

.PHONY: check-version
check-version:
	docker run --rm $(DOCKER_NAMESPACE)/$(DOCKER_IMAGE):$(VERSION) printenv|grep ATOM_VERSION| awk -F '=' '{print $$2}'
