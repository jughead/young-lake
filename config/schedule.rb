# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

set :environment, ENV['RAILS_ENV'] || 'production'
set :output, File.expand_path('../../log/cron.log', __FILE__)

every 15.minutes do
  rake 'events:notifications:mail'
end
