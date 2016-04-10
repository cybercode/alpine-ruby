FROM alpine:3.3
ENV RUBY_VERSION=2.3.0

RUN apk update && apk upgrade && apk --update add gmp yaml tzdata bash

# add compilation env, build ruby and cleanup
RUN apk --update add --virtual build_deps \
    build-base libffi-dev openssl-dev  \
    linux-headers zlib-dev readline-dev yaml-dev git \
    && cd /tmp && git clone https://github.com/rbenv/ruby-build.git \
    && cd ruby-build && ./install.sh \
    && ruby-build $RUBY_VERSION /usr/local \
    && rm -rf /tmp/* /usr/local/bin/ruby-build /usr/local/share/* \
        /usr/local/lib/libruby-static.a \
    && apk del build_deps && rm /var/cache/apk/*

RUN echo 'gem: --no-rdoc --no-ri' >/etc/gemrc

RUN gem install bundler \
    && rm -r /root/.gem \
    && find / -name '*.gem' | xargs rm

CMD ["irb"]
