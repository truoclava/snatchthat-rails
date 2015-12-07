class Search < ActiveRecord::Base

  def self.amazon_data
    request = Vacuum.new('US')
    request.configure(
      aws_access_key_id: ENV['aws_access_key_id'],
      aws_secret_access_key: ENV['aws_secret_access_key'],
      associate_tag: 'tag'
    )

    response = request.item_search(
      query: {
      'Keywords' => 'Architecture',
      'SearchIndex' => 'Books'
      }
    )

  end

end
