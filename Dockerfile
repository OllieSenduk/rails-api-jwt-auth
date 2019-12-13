# Args specified in the docker-compose.yml file
ARG RUBY_VERSION

FROM ruby:$RUBY_VERSION

ARG PG_MAJOR
ARG BUNDLER_VERSION

# Add PostgreSQL to sources list
RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && echo 'deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main' $PG_MAJOR > /etc/apt/sources.list.d/pgdg.list

RUN apt-get update -qq && apt-get install -y postgresql-client-$PG_MAJOR
RUN mkdir /usr/src/app
WORKDIR /usr/src/app
COPY Gemfile /usr/src/app/Gemfile
COPY Gemfile.lock /usr/src/app/Gemfile.lock

ENV BUNDLER_VERSION $BUNDLER_VERSION
RUN gem install bundler:$BUNDLER_VERSION

RUN bundle install
COPY . /usr/src/app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Add a script to be executed every time the container starts.
CMD RAILS_ENV=${RAILS_ENV} bundle exec rails db:create db:migrate db:seed && bundle exec rails s -p ${PORT} -b '0.0.0.0'