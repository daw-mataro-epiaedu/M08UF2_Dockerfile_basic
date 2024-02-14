#FROM is the base image for which we will run our application
FROM nginx:latest
# Copy files and directories from the application
COPY html/index.html /usr/share/nginx/html
COPY html/favicon.ico /usr/share/nginx/html
COPY html/Rakefile /usr/share/nginx/html
COPY html/style/ /usr/share/nginx/html/style/
COPY html/meta/ /usr/share/nginx/html/meta/
COPY html/js/ /usr/share/nginx/html/js/

# Tell Docker we are going to use this port
EXPOSE 80