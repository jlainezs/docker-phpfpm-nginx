# Dockerize a PHP application

This template creates a docker image with php-fpm and nginx. As some services require to deploy only one docker image on new VM instances, this project template has the needed code to pack into one single container:

* Application files
* PHP-FPM 8.1
* NGINX

## Prepare your image

* Adjust configuration files under ```configuration``` folder.
* Copy your application source code into the ```application``` folder.

## Build

To build the image launch ```./build.sh``` from a terminal. This step may take some time.

Test if the image is right running ```docker run -p 80:80 img_name``` and pointing a brownser to http://localhost

At this point you may want to launch some test suite to ensure that everything is working as expected.

If the image is ready then you can deploy it to a container registry.

## Refrences


* [php-fpm and nginx in one container](https://stackoverflow.com/questions/46332919/combining-php-fpm-with-nginx-in-one-dockerfile)
* [docker build reference](https://docs.docker.com/engine/reference/commandline/build/)
* [set docker image name](https://stackoverflow.com/questions/38986057/how-to-set-image-name-in-dockerfile)
* [using environment variables](https://www.baeldung.com/linux/nginx-config-environment-variables)
* [Load .env variables](https://gist.github.com/mihow/9c7f559807069a03e302605691f85572)

## Optimize image

* [Reduce image size](https://devopscube.com/reduce-docker-image-size/)

