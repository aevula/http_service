FROM ruby:3.4.1-alpine3.21 AS development

RUN apk add --no-cache build-base tzdata

WORKDIR /opt/app/

COPY Gemfile* http_service.gemspec ./
COPY lib/http_service/version.rb lib/http_service/version.rb

RUN bundle install -j 4

CMD ["bundle", "exec", "rake"]
