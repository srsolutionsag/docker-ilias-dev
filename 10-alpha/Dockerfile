ARG ILIAS_VERSION

FROM srsolutions/ilias-base:${ILIAS_VERSION}

ENV ILIAS_DEVMODE=1

RUN curl -sS https://getcomposer.org/installer \
    | php -- --2 --install-dir=/usr/local/bin --filename=composer

ARG NODE_VERSION=20.10.0
RUN curl -o /opt/node.tar.xz -SL https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz \
    && mkdir /opt/node \
    && tar -xJf /opt/node.tar.xz -C /opt/node --strip-components=1 --no-same-owner \
    && rm /opt/node.tar.xz \
    && ln -s /opt/node/bin/node /usr/local/bin/node \
    && ln -s /opt/node/bin/npm /usr/local/bin/npm

RUN case ${PHP_VERSION} in \
    8.2*) \
        pecl install xdebug \
        ;; \
    8.3*) \
        pecl install xdebug-3.3.0alpha3 \
        ;; \
    esac

RUN echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)\n\
xdebug.mode = develop,debug,profile\n\
xdebug.discover_client_host = true\n\
xdebug.client_port = 9000\n\
xdebug.log = /var/log/xdebug.log\n\
xdebug.start_with_request = trigger\n\
xdebug.output_dir = /var/iliasdata/ilias" \
> /usr/local/etc/php/conf.d/xdebug.ini \
    && touch /var/log/xdebug.log \
    && chown www-data /var/log/xdebug.log

RUN echo "error_reporting = E_ALL & ~E_NOTICE & ~E_WARNING & ~E_STRICT & ~E_DEPRECATED\n\
display_errors = On" \
> /usr/local/etc/php/conf.d/z_ilias-dev.ini
