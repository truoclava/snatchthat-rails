# bundle exec whenever --update-crontab
# bundle exec whenever

# see if whenever is good uploaded by running in terminal: whenever
# check if crontab is good implemented on the server: crontab -l
# to stop the program crontab -r
# to check if this is working, check log/cron.log
# update whenever crontab by running: whenever --update-crontab
# restart the server crontab (for example in Ubuntu server): sudo service cron restart





set :environment, :development
set :output, "#{path}/log/cron.log"

every 10.minutes do
  rake 'price_check'
end

every 1.minutes do
  rake 'cron_test'
end
