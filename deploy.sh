#!/bin/sh

set -ex

bundle exec middleman build --clean
rsync -avz build/ opensourcery.blog@192.168.196.27:/var/www/opensourcery.blog/public_html/
