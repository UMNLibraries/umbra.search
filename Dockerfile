FROM ruby:2.5.5

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash \
    && apt-get update && apt-get install -qq -y --no-install-recommends \
      build-essential nodejs

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

RUN mkdir /umbra.search
WORKDIR /umbra.search
ADD . /umbra.search
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install --without production