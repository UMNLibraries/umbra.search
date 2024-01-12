FROM ruby:2.5.5

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash \
    && apt-get update && apt-get install -qq -y --no-install-recommends \
      build-essential nodejs libmariadbd19

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

RUN mkdir /app
WORKDIR /app
ADD . /app
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install --without production
