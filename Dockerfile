FROM nginx:alpine-latest

# Cloner le dépôt Git dans le répertoire de contenu de Nginx
WORKDIR /usr/share/nginx/html
COPY . .
RUN git clone https://github.com/diranetafen/static-website-example.git .

EXPOSE 80

ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]