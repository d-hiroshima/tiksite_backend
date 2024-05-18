FROM php:8.3-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    unzip \
    curl \
    git \
    && docker-php-ext-configure gd --with-jpeg --with-freetype \
    && docker-php-ext-install pdo_mysql mbstring zip exif pcntl gd \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Increase file upload size
RUN echo "post_max_size = 200M" > /usr/local/etc/php/conf.d/upload_large_dumps.ini \
    && echo "upload_max_filesize = 200M" >> /usr/local/etc/php/conf.d/upload_large_dumps.ini

# Set working directory
WORKDIR /var/www

# Remove the default Nginx index page
RUN rm -rf /var/www/html

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
