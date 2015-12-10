# to excute the code below, type 'bundle exec whenever' in the terminal
# to stop the program crontab -r
# to check if this is working, check log/cron.log

set :environment, :development
set :output, "#{path}/log/cron.log"

every 10.minutes do
  rake 'price_check'
end
