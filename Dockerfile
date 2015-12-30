FROM alpine:3.3

RUN apk update && apk upgrade && apk --update add \
    ruby ruby-irb ruby-rake ruby-io-console ruby-bigdecimal \
    libstdc++ tzdata

RUN echo 'gem: --no-rdoc --no-ri' >/etc/gemrc
RUN gem install bundler \
    && rm -r /root/.gem \
    && find / -name '*.gem' | xargs rm

CMD ["irb"]
