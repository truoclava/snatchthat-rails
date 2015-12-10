# == Schema Information
#
# Table name: searches
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Search < ActiveRecord::Base

  attr_accessor :keyword, :source_type

  def initialize(keyword, source_type)
    @keyword = keyword
    @source_type = source_type
  end

  def results
    if self.source_type == 'Amazon'
      self.amazon_hash
    else
      self.hidefy_hash
    end
  end

  def amazon_hash
    #source_id = "B014NHULAE"
    client = Adapters::AmazonSearchClient.new
    results = client.amazon_search(self.keyword)
    items = results['ItemSearchResponse']['Items']['Item']
    self.amazon_parser(items)
  end

  def amazon_parser(items)
    results = []
    items.each do |item|
      source_id = item['ASIN']
      name = item['ItemAttributes']['Title']
      url = item['DetailPageURL']
      if item['MediumImage'].blank?
        item['MediumImage'] = ''
      end
      image_url =  item['MediumImage']['URL']
      price = item['OfferSummary']['LowestNewPrice']['FormattedPrice']
      results << self.item_hash(source_id, name, url, image_url, price)
      end
    return results
  end

  def self.hedify_hash_parser(keyword)
    results = Adapters::HidefyConnection.new.query("items")["items"]
    results_array = []
    results.each do |result|
      source_id = result['id']
      name = result['name']
      url = result['url']
      image_url = result['image_url']
      price = result['price'].to_s
      results_array << self.item_hash(source_id, name, url, image_url, price)
    end
    results_array
  end

  def item_hash(source_id, name, url, image_url, price)
    {
      'source_id' => source_id,
      'name' => name,
      'url' => url,
      'image_url' => image_url,
      'price' => price ,
    }
  end

end
