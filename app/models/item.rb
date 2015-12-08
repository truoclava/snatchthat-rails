# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  name       :string
#  url        :string
#  price      :integer
#  source_id  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Item < ActiveRecord::Base
  has_many :closet_items
  has_many :closets, through: :closet_items
  has_many :prices


  def client
    rename = Adapters::AmazonConnection.new
    rename.connection
  end

  def response
    client.item_lookup(
    query: {
      'ItemId' => self.source_id,
      'ResponseGroup' => 'ItemAttributes, Images, Offers, Variations'
    }).to_h
  end

  def item_attributes
    response['ItemLookupResponse']['Items']['Item']['ItemAttributes']
  end

  def get_current_price
    item_attributes['ListPrice']['FormattedPrice'].gsub(/[^\d\.]/, '').to_i
  end

  def amazon_info
    self.name = item_attributes['Title']
    self.price = get_current_price
    self.image_url = response['ItemLookupResponse']['Items']['Item']['MediumImage']['URL']
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




end
