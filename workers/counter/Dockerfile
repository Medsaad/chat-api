FROM ruby:2.5

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs cron && rm -rf /var/lib/apt/lists/*

RUN mkdir /app
WORKDIR /app

ADD . .
RUN bundle install

# Creating Non-priviliged user
RUN useradd -ms /bin/bash admin

RUN chown -R admin:admin *

RUN bundle exec whenever --update-crontab

EXPOSE 3001
