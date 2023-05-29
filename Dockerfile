FROM ruby:2.7.6-alpine

EXPOSE 8082
RUN apk update \
    && apk add --no-cache \
        tzdata \
        build-base \
        nodejs \
        yarn \
        sqlite-dev \
        git\
    && rm -rf /var/cache/apk/*

COPY package.json yarn.lock ./
RUN yarn install --check-files

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler -v 1.17.3 && \
    bundle config build.nokogiri --use-system-libraries && \
    rm -rf /usr/lib/lib/ruby/gems/*/cache/*

COPY . .

RUN git config --global --add safe.directory /app && \
    bundle install --without development test && \
    bundle exec rake assets:precompile

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
