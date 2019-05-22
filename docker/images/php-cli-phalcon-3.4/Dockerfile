FROM magroski/php-dev:cli

ENV PHALCON_VERSION=3.4.2

RUN cd /usr/src \
        && curl -sSL "https://codeload.github.com/phalcon/cphalcon/tar.gz/v${PHALCON_VERSION}" | tar -xz \
        && cd cphalcon-${PHALCON_VERSION}/build \
        && ./install \
        && cd ../../ \
        && rm -r cphalcon-${PHALCON_VERSION} \
        && echo 'extension=phalcon.so' > "$PHP_INI_DIR/conf.d/ext-phalcon.ini"
