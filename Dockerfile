FROM alpine:edge

RUN apk update && apk upgrade && apk --update add \
    ruby ruby-irb ruby-rake ruby-io-console ruby-bigdecimal \
    libstdc++ tzdata

RUN gem install bundler --no-ri --no-rdoc \
    && rm -r /root/.gem \
    && find / -name '*.gem' | xargs rm

CMD ["irb"]
