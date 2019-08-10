FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /app
WORKDIR /app

ADD . .
RUN bundle install

# Creating Non-priviliged user
RUN useradd -ms /bin/bash admin

RUN chown -R admin:admin *

EXPOSE 3001
