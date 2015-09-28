FROM alpine:3.2

RUN apk update && apk upgrade && apk --update add \
    ruby ruby-irb ruby-rake ruby-io-console ruby-bigdecimal \
    libstdc++ tzdata

RUN gem install bundler --no-ri --no-rdoc

CMD ["irb"]
