#!/bin/sh

set -ex

# Build a nice clean version of the site so we don't have any stale files lying around
bundle exec middleman build --clean

# Use wrangler to deploy the site to Cloudflare Pages for us (requires environment variables to be set)
yarn wrangler pages deploy build --project-name=opensourcery "$@"