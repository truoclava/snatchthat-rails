# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  name       :string
#  url        :string
#  source_id  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Item < ActiveRecord::Base
  has_many :closet_items
  has_many :closets, through: :closet_items


def get_current_price
  AmazonAdapter.new(self).price
  request = Vacuum.new('US')

  request.configure(
    aws_access_key_id: ENV['aws_access_key_id'],
    aws_secret_access_key: ENV['aws_secret_access_key'],
    associate_tag: 'tag'
  )

  response = request.item_lookup(
  query: {
    'ItemId' => self.source_id,
    'ResponseGroup' => "ItemAttributes"
  })

  item_attributes = response.to_h['ItemLookupResponse']['Items']['Item']['ItemAttributes']
  current_price = item_attributes['ListPrice']['FormattedPrice']
  current_price = current_price.gsub(/[^\d\.]/, '').to_i

  return current_price
end

end
