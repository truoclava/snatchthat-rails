
# to excute the code below, type 'bundle exec whenever -w' in the terminal
# to close whenever -c theCronJob

set :environment, :development
set :output, "#{path}/log/cron.log"

every 10.minutes do
  rake 'price_check'
end
