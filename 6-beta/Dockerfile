ARG ILIAS_VERSION

FROM sturai/ilias:${ILIAS_VERSION}

ENV ILIAS_DEVMODE=1

RUN pecl install xdebug

RUN echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)\n\
xdebug.remote_enable = 1\n\
xdebug.remote_connect_back = 1\n\
xdebug.remote_port = 9000\n\
xdebug.remote_log = /var/log/xdebug.log\n\
xdebug.idekey = PHPSTORM\n\
xdebug.profiler_enable_trigger = 1\n\
xdebug.profiler_output_dir = /var/iliasdata/ilias" \
> /usr/local/etc/php/conf.d/xdebug.ini \
    && touch /var/log/xdebug.log \
    && chown www-data /var/log/xdebug.log

RUN echo "error_reporting = E_ALL & ~E_NOTICE & ~E_WARNING & ~E_STRICT\n\
display_errors = On" \
> /usr/local/etc/php/conf.d/ilias-dev.ini
