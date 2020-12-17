install:
	yarn install

build:
	#yarn cache clean
	#yarn build
	INLINE_RUNTIME_CHUNK=false npm run build
	mv build/index.html build/static/
	mv src/routes.json build/static/