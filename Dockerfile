FROM ruby:2.5.1

ENV app /opt/app
RUN mkdir -p $app

COPY . $app

WORKDIR $app

RUN bundle install -j 10
