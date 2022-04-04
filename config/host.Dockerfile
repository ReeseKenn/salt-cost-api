FROM ruby:3.0.0

ENV RAILS_ENV production
RUN mkdir /salt-cost
RUN bundle config mirror.https://rubygems.org https://gems.ruby-china.com
WORKDIR /salt-cost
ADD salt-cost-*.tar.gz ./
RUN bundle config set --local without 'development test'
RUN bundle install --local
ENTRYPOINT bundle exec puma
