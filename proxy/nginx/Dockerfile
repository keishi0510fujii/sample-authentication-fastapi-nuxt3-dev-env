FROM nginx:1.22.0-alpine as base
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./conf.d/default.conf /etc/nginx/conf.d/default.conf
RUN apk update && \
    apk add --upgrade tini

FROM nginx:1.22.0-alpine as dev
COPY --from=base --chown=nginx:nginx /sbin/tini /sbin/tini
COPY --from=base --chown=nginx:nginx /etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=base --chown=nginx:nginx /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf
EXPOSE 1025
USER nginx