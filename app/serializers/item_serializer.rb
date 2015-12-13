class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :source_id, :source_type, :image_url, :closet_ids
end
