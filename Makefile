setup:
#	setup用イメージのビルド
	@TARGET=base TAG=setup docker-compose build
#	コンテナからホストにパッケージをコピー
	@docker run --name sample_authentication_frontend_nuxt3 -itd sample_authentication_frontend_nuxt3:setup
	@docker cp -a sample_authentication_frontend_nuxt3:/app/node_modules ./frontend/authentication-nuxt3/app/
	@docker cp -a sample_authentication_frontend_nuxt3:/app/.nuxt ./frontend/authentication-nuxt3/app/
#	mysqlのイメージをpull
	@docker pull mysql:8.0
#	キャッシュ以外は削除
	@docker stop sample_authentication_frontend_nuxt3 && docker rm sample_authentication_frontend_nuxt3

IMAGES=`docker images 'sample_authentication*' -q`
destroy:
	@if [ "$(IMAGES)" != "" ] ; then \
		docker rmi -f `docker images 'sample_authentication*' -q`; \
	else \
		echo 'no images "sample_authentication*"'; \
	fi
	@rm -rf ./frontend/authentication-nuxt3/app/node_modules ./frontend/authentication-nuxt3/app/.nuxt
	@docker builder prune -f
	@docker volume rm -f `docker volume ls -q | grep sample-authentication`

build:
	@docker-compose build
up:
	@docker-compose up -d
down:
	@docker-compose down
clean:
	@docker rmi -f `docker images 'sample_authentication*' -q`