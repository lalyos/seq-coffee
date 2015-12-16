deps:
	[ -a /usr/local/bin/sigil ] || curl -L https://github.com/gliderlabs/sigil/releases/download/v0.3.3/sigil_0.3.3_$(shell uname)_x86_64.tgz \
		| tar -xz -C /usr/local/bin/

build: deps
	sigil -f images.tmpl > index.html

deploy: build
	aws s3 sync . s3://seq-coffee

preview-local: build
	open index.html

preview: build
	open http://seq-coffee.s3-website-eu-west-1.amazonaws.com

init:
	aws s3 mb s3://seq-coffee
	aws s3 website --index-document index.html s3://seq-coffee/
