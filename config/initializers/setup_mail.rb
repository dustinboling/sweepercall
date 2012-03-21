# This sets up the base url to tag on urls to like so: <%= $RESOURCE_NAME_url %>
ActionMailer::Base.default_url_options[:host] = "sweepercall.heroku.com"