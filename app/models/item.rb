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

  
  # def get_asin
  #   self.source_id = self.url.match("/([a-zA-Z0-9]{10})(?:[/?]|$)")[1]
  # end

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


end
