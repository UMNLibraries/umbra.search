FROM ruby:2.1.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN mkdir /umbra.search
WORKDIR /umbra.search
ADD . /umbra.search
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install --without production