# == Schema Information
#
# Table name: searches
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Search < ActiveRecord::Base


  def self.amazon_data
    rename = Adapters::AmazonConnection.new
    client = rename.connection

    client.item_search(
    query: {
      'Keywords' => 'Architecture',
      'SearchIndex' => 'Books'
    }).to_h

  end

end
