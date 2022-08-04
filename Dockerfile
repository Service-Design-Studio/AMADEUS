# Use the official lightweight Ruby image.
# https://hub.docker.com/_/ruby
FROM ruby:3.0.0 AS rails-toolbox
ARG NLP_API_KEY_ARG="YOUR CLOUD SERVICE ACCOUNT API_KEY"
ARG SECRET_KEY_BASE_ARG="YOUR SECRET RAILS PRODUCTION KEY"

# Install dependencies
RUN (curl -sS https://deb.nodesource.com/gpgkey/nodesource.gpg.key | gpg --dearmor | apt-key add -) && \
    echo "deb https://deb.nodesource.com/node_14.x buster main"      > /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && apt-get install -y nodejs lsb-release
RUN wget https://dl.yarnpkg.com/debian/pubkey.gpg
RUN curl https://deb.nodesource.com/setup_18.x | bash
RUN cat pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

# Prepare Rails app
WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN apt-get update && apt-get install -y libpq-dev && apt-get install -y python3-distutils
RUN gem install bundler && \
    bundle config set --local deployment 'true' && \
    bundle config set --local without 'development test' && \
    bundle install

COPY . /app
WORKDIR /app

# Set ENV
ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_LOG_TO_STDOUT=true
ENV NLP_API_KEY=$NLP_API_KEY_ARG
ENV SECRET_KEY_BASE=$SECRET_KEY_BASE_ARG

# Run rails
EXPOSE 3000
EXPOSE 6379

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
