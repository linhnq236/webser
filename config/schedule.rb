# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
env :PATH, ENV['PATH']
env :GEM_PATH, ENV['GEM_PATH']
set :output, "log/cron_log.log"

set :environment, "development"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end
# Learn more: http://github.com/javan/whenever
# every 1.minute do
# every :day, at: '10:48pm' do
#   rake "custom:auto_send_email"
# end

# every 1.minute do
#   runner "Reminder.test"
# end
every 1.minute do
  rake "auto_ledcontroller:auto_leds"
end

every :day, at: '12:57pm' do
  rake "reminder:reminder_rental"
end
