ARG ILIAS_VERSION

FROM srsolutions/ilias-base:${ILIAS_VERSION}

ARG TARGETARCH

ENV ILIAS_DEVMODE=1

ARG NODE_VERSION=20.19.5

RUN case ${TARGETARCH} in amd64) NODE_ARCH=x64 ;; arm64) NODE_ARCH=arm64 ;; *) exit 1 ;; esac \
    && curl -o /opt/node.tar.xz -SL https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-${NODE_ARCH}.tar.xz \
    && mkdir /opt/node \
    && tar -xJf /opt/node.tar.xz -C /opt/node --strip-components=1 --no-same-owner \
    && rm /opt/node.tar.xz \
    && ln -s /opt/node/bin/node /usr/local/bin/node \
    && ln -s /opt/node/bin/npm /usr/local/bin/npm

RUN npm install -g sass

RUN pecl install xdebug

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
