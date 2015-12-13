class ClosetSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_id, :item_ids
  
end
