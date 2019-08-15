NAME = imtlab/baseimage
VERSION = 18.0.1

.PHONY: all build_all clean clean_images \
	build_node10153 \
	build_node10163 \
	release test tag_latest

all: build_all

build_all: \
	build_node10153 \
	build_node10163

build_node10153:
	rm -rf node10153_image
	cp -pR image node10153_image
	echo node10153=1 >> node10153_image/buildconfig
	echo final=1 >> node10153_image/buildconfig
	sed -i -e "s/##TAG##/$(VERSION)/" node10153_image/Dockerfile
	docker build -t $(NAME)-node:10.15.3-$(VERSION) --rm node10153_image

build_node10163:
	rm -rf node10163_image
	cp -pR image node10163_image
	echo node10163=1 >> node10163_image/buildconfig
	echo final=1 >> node10163_image/buildconfig
	sed -i -e "s/##TAG##/$(VERSION)/" node10163_image/Dockerfile
	docker build -t $(NAME)-node:10.16.3-$(VERSION) --rm node10163_image

clean:
	rm -rf node10153_image
	rm -rf node10163_image

clean_images:
	@if docker images $(NAME)-node:10.15.3-$(VERSION) | awk '{ print $$2 }' | grep -q -F $(VERSION); then docker rmi -f $(NAME)-node:10.15.3-$(VERSION) || true; fi
	@if docker images $(NAME)-node:10.16.3-$(VERSION) | awk '{ print $$2 }' | grep -q -F $(VERSION); then docker rmi -f $(NAME)-node:10.16.3-$(VERSION) || true; fi

tag_latest:
	docker tag $(NAME)-node:10.15.3-$(VERSION) $(NAME)-node:latest
	docker tag $(NAME)-node:10.16.3-$(VERSION) $(NAME)-node:latest

release: test tag_latest
	@if ! docker images $(NAME)-node:10.15.3-$(VERSION) | awk '{ print $$2 }' | grep -q -F 10.15.3-$(VERSION); then echo "$(NAME)-node:10.15.3-$(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-node:10.16.3-$(VERSION) | awk '{ print $$2 }' | grep -q -F 10.16.3-$(VERSION); then echo "$(NAME)-node:10.16.3-$(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME)-node

test:
	@if docker images $(NAME)-node:10.15.3-$(VERSION) | awk '{ print $$2 }' | grep -q -F $(VERSION); then env NAME=$(NAME)-node:10.15.3 NODE='v10.15.3' VERSION=$(VERSION) test/runner.sh; fi
	@if docker images $(NAME)-node:10.16.3-$(VERSION) | awk '{ print $$2 }' | grep -q -F $(VERSION); then env NAME=$(NAME)-node:10.16.3 NODE='v10.16.3' VERSION=$(VERSION) test/runner.sh; fi