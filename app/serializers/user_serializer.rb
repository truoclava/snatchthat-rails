class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :closet_ids
end
