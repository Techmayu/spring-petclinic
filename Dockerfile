FROM nginx:stable
COPY ./dist /usr/share/nginx/html
EXPOSE 80
HEALTHCHECK --interval=10s --timeout=3s \ CMD curl -f http://localhost/ || exit 1
