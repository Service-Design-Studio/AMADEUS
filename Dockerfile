# Use the official lightweight Ruby image.
# https://hub.docker.com/_/ruby
FROM ruby:3.0.0 AS rails-toolbox

# Install dependencies
## node
RUN (curl -sS https://deb.nodesource.com/gpgkey/nodesource.gpg.key | gpg --dearmor | apt-key add -) && \
    echo "deb https://deb.nodesource.com/node_14.x buster main"      > /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && apt-get install -y nodejs lsb-release
## yarn
RUN wget https://dl.yarnpkg.com/debian/pubkey.gpg
RUN curl https://deb.nodesource.com/setup_18.x | bash
RUN cat pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn
## redis
RUN apt-get update
RUN apt-get install redis-server -y

# Prepare Rails app
WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN apt-get update && apt-get install -y libpq-dev && apt-get install -y python3-distutils
RUN gem install bundler && \
    bundle config set --local deployment 'true' && \
    bundle config set --local without 'development test' && \
    bundle install

ARG CACHEBUST=1
COPY . /app
WORKDIR /app

# Rails ENV
ARG MASTER_KEY
ENV RAILS_MASTER_KEY=${MASTER_KEY}
ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_LOG_TO_STDOUT=true

# Rake task
RUN bundle exec rake assets:precompile
RUN bundle exec rake db:create
RUN bundle exec rake db:migrate

EXPOSE 3000

CMD ["bundle", "exec", "foreman", "start", "-f", "Procfile.dev"]
