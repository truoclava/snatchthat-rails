class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :closet_ids, :item_ids
end
