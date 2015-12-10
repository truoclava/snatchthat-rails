FactoryGirl.define do
  factory :user do
     email 'john@flatironschool.com'
     username 'hide'
     password 'wodepengyou'
     password_confirmation 'wodepengyou'
     confirmed_at Date.today
    # factory :user_with_closets do
    #
    #   transient do
    #   closets_count
    #   end
    #
    # end
  end
end
