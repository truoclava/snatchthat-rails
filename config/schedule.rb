
set  :output, "#{path}/log/cron.log"

every 1.minutes do
  command "Item.price_change_up"
end
