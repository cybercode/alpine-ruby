FROM alpine:3.5

RUN apk update && apk upgrade && apk --update add \
    ruby ruby-irb ruby-rake ruby-io-console ruby-bigdecimal ruby-json ruby-bundler \
    libstdc++ tzdata bash ca-certificates \
    &&  echo 'gem: --no-document' > /etc/gemrc

CMD ["irb"]
