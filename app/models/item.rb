# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  name        :string
#  url         :string
#  price       :integer
#  source_id   :string
#  source_type :string
#  image_url   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Item < ActiveRecord::Base
  has_many :closet_items
  has_many :closets, through: :closet_items, :counter_cache => true
  has_many :prices

  validates :source_id, presence: true, uniqueness: true
  validates :source_type, presence: true

  def exists?
    Item.exists?(source_id: self.source_id)
  end

  def get_hidefy_price(end_path)
    hidefy_item_data = Adapters::HidefyConnection.new.query(end_path)
    current_price = hidefy_item_data["price"]
  end

  def hidefy_create(item_id)
    current_price = get_hidefy_price("items/#{item_id}")
    new_price = Price.new(price: current_price)
    self.prices << new_price
  end

  def self.most_popular
    count = []
    Item.all.each_with_index do |item, i|
      count << item.closets.count
    end
    Item.find(count.index(count.max)+1)
  end

  def get_amazon_price(asin)
    Adapters::AmazonPriceClient.new.get_amazon_price(source_id)
  end

  def last_24hr_prices
    prices_instance_array = prices.where(created_at: (Time.now - 24.hours)..Time.now)
    price_array = []
    prices_instance_array.each do |price|
      price_array << price.price.to_i
    end
    price_array
  end

  def stats
    last_24hrs_array = last_24hr_prices
    stats = DescriptiveStatistics::Stats.new(last_24hrs_array)
    # returns stats instance
  end

  def price_dif
    last_price = self.prices[-1]
    second_last_price = self.prices[-2]
    price_change = last_price.price.to_i - second_last_price.price.to_i
  end




end
