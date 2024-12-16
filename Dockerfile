FROM nginx:alpine

# Copiez votre fichier de configuration Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copiez les fichiers de votre application
COPY . /usr/share/nginx/html

# Exposez le port que Nginx va utiliser
EXPOSE 8080