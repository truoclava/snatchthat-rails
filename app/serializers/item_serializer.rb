class ItemSerializer < ActiveModel::Serializer
  attributes :name, :url, :source_id, :source_type, :image_url, :closet_ids
end
