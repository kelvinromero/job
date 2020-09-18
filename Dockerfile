FROM ruby:2.5.3
RUN apt-get update \
    && apt-get install default-libmysqlclient-dev -y \
    && apt-get install -y nodejs --no-install-recommends
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle update --bundler
RUN bundle install
EXPOSE 3000