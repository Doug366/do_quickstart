FROM ruby:2.2.0
RUN apt-get update -qq && apt-get install -y build-essential libxml2-dev libxslt1-dev libgmp3-dev nodejs npm mysql-client libmysqlclient-dev libmysqld-dev
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
ADD . /myapp
