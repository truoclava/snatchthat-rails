desc "Automatic price check"

task :price_check => :environment do
  Price.price_check
  puts "price checked at #{Time.now}"
end

task :cron_test => :environment do
  puts "cron test at #{Time.now}"
end
