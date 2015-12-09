desc "Automatic price check"

task :price_check => :environment do
  Price.price_check
end
