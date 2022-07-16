# Layer 0. Download base ruby image.
FROM ruby:3.1.1-slim

# Layer 1. Updating and installing the necessary software for the Web server. Cleansing to reduce image size.
RUN apt-get update -qq && apt-get install --no-install-recommends -y \
  build-essential vim libpq-dev libxml2-dev libxslt1-dev imagemagick apt-transport-https postgresql-client libxrender1 git && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Layer 2. Creating environment variables which used further in Dockerfile.
ENV APP_HOME /home/www/rails-app

# Layer 3. Adding config options for bundler.
RUN echo "gem: --no-rdoc --no-ri" > /etc/gemrc

# Layer 4. Creating and specifying the directory in which the application will be placed.
WORKDIR $APP_HOME

# Layer 5. Copying Gemfile and Gemfile.lock.
COPY Gemfile Gemfile.lock ./

EXPOSE 3000/tcp

# Layer 6. Installing dependencies.
RUN bundle check || bundle install --jobs 20 --retry 5

# Layer 7. Copying full application.
COPY . .

# Layer 8. Command to run application.
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
