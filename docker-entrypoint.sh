#!/bin/sh
set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

if [ ! -f config/credentials.yml.enc ]; then
  echo "credentials not found!"
  echo "initializing..."

  EDITOR='echo "$(cat credentials.example.yml)" > ' rails credentials:edit
fi

bundle exec rails db:create
bundle exec rails db:migrate
# bundle exec rails db:seed

exec "$@"
