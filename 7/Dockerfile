ARG ILIAS_VERSION

FROM srsolutions/ilias-base:${ILIAS_VERSION}

ENV ILIAS_DEVMODE=1

RUN pecl install xdebug-3.1.6

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

RUN echo "error_reporting = E_ALL & ~E_NOTICE & ~E_WARNING & ~E_STRICT\n\
display_errors = On" \
> /usr/local/etc/php/conf.d/ilias-dev.ini
