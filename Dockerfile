FROM php:7-apache

#Update the package
RUN apt update

#Install zip, git and nginx
RUN apt install -y \
    zip \
    git \
    nginx

#Install mysqli extension for php
RUN docker-php-ext-install pdo_mysql mysqli

#To retrieve the Composer installer using curl, download and install it in /usr/local/bin directory
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# To define the working directory of the Docker container
WORKDIR /var/www/html

#To Prepare the application environment and install the dependencies:
COPY . .
RUN cp /var/www/html/.env.sample /var/www/html/.env 
RUN chown -R www-data:www-data /var/www
RUN chmod +x artisan

RUN composer install
RUN php artisan db:seed
RUN php artisan key:generate


# Run php artisan migrate
CMD php artisan migrate

# Run php artisan serve to test and start the project.
ENTRYPOINT php artisan serve --host 0.0.0.0 --port 5001