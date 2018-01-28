#FROM php:5.6.31-fpm
FROM php:7.2-fpm

RUN apt-get update && apt-get install -y libmcrypt-dev \
    mysql-client libmagickwand-dev libcurl4-gnutls-dev libxslt1-dev libicu-dev libkrb5-dev libc-client-dev libmemcached-dev sudo --no-install-recommends \
    && pecl install imagick \
    && pecl install mongodb-1.3.4 \
    && pecl install redis-3.1.4 \
    && pecl install memcached-3.0.4 \
    && docker-php-ext-enable imagick \
    && docker-php-ext-install pdo_mysql curl gd mbstring xsl intl soap zip \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap \
    && docker-php-ext-enable mongodb redis memcached

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/bin/composer \
    && mkdir -p /usr/local/etc/php/conf.d \
    && touch /usr/local/etc/php/conf.d/php.ini \
    && echo "date.timezone = Europe/Berlin" >> /usr/local/etc/php/php.ini \
    && echo "memory_limit = 8G" >> /usr/local/etc/php/php.ini

RUN apt-get install -y gnupg2 apt-transport-https \
    && curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install -y nodejs yarn

RUN useradd -c 'incent user' -m -d /home/incent -s /bin/bash incent
RUN chown -R incent:www-data /var/www
#USER incent
#ENV HOME /home/incent
ENV PATH="/var/www/vendor/bin:${PATH}"