FROM alpine:3.3
ENV RUBY_VERSION=2.3.1

RUN apk update && apk upgrade && apk add gmp yaml tzdata bash

# add compilation env, build ruby and cleanup
RUN apk --update add --virtual build_deps \
    build-base libffi-dev openssl-dev  \
    linux-headers zlib-dev readline-dev yaml-dev git \
    && cd /tmp && git clone https://github.com/rbenv/ruby-build.git \
    && cd ruby-build && ./install.sh \
    && ac_cv_func_isnan=yes ac_cv_func_isinf=yes \
       CONFIGURE_OPTS="--enable-pthread --disable-rpath --enable-shared" \
       RUBY_CFLAGS="-fno-omit-frame-pointer -fno-strict-aliasing" \
       RUBY_CONFIGURE_OPTS=--disable-install-doc \
       ruby-build -v $RUBY_VERSION /usr/local \
    && cd .. \
    && rm -rf /tmp/* /usr/local/bin/ruby-build /usr/local/share/* \
        /usr/local/lib/libruby-static.a \
    && mkdir -p /usr/local/etc && echo 'gem: --no-document' >/usr/local/etc/gemrc \
    && gem update --system && gem update && gem clean && gem install bundler \
    && rm -rf /root/.gem \
    && find / -name '*.gem' | xargs rm -f \
    && apk del build_deps && rm /var/cache/apk/*

CMD ["irb"]
