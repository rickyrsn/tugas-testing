# Use the official PHP 7.3 Apache image as the base image
FROM php:7.3-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    zip \
    unzip \
    curl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install mysqli pdo pdo_mysql \
    && docker-php-ext-enable mysqli

# Enable Apache mod_rewrite for clean URLs
RUN a2enmod rewrite

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /var/www/html

# Copy project files into the container
COPY . /var/www/html

# Set permissions for www-data
RUN chown -R www-data:www-data /var/www/html

# Set environment variable for server name (to prevent Apache warning)
ENV SERVER_NAME=localhost

# Expose port 80 for Apache
EXPOSE 80

# Restart Apache to apply changes
RUN service apache2 restart

# Set the default command to run Apache in the foreground
CMD ["apache2-foreground"]
