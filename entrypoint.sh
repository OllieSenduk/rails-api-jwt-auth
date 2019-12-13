#!/bin/bash
set -e

# Create the Rails production DB on first run
bundle exec rails db:create

# Make sure we are using the most up to date
# database schema
bundle exec rails db:migrate

# Remove a potentially pre-existing server.pid for Rails.
rm -f /usr/src/app/tmp/pids/server.pid

exec "$@"