# == Schema Information
#
# Table name: searches
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Search < ActiveRecord::Base

  def self.create_results_hash(keyword, source_type)
    if source_type == 'Amazon'
      self.amazon_hash_parser(keyword)
    else source_type == 'Hidefy'
      self.hedify_hash_parser(keyword)
    end
  end

  def self.amazon_hash_parser(keyword)
    client = Adapters::AmazonSearchClient.new
    results = client.amazon_search(keyword)
    results_array = []
    results.each do |result|
      source_id = result['ASIN']
      name = result['ItemAttributes']['Title']
      url = result['DetailPageURL']
      image_url =  result['MediumImage']['URL']
      price = result['OfferSummary']['LowestNewPrice']['FormattedPrice']
      results_array << self.item_hash(source_id, name, url, image_url, price)
    end
    results_array
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

  def self.item_hash(source_id, name, url, image_url, price)
    {
      'source_id' => source_id,
      'name' => name,
      'url' => url,
      'image_url' => image_url,
      'price' => price ,
    }
  end

end
