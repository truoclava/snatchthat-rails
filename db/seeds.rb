# Users
User.create!(username:  "ExampleUser",
             email: "example@railstutorial.org",
             phone_number: "9827362518",
             password:              "foobarfoobar",
             password_confirmation: "foobarfoobar")

99.times do |n|
  name  = Faker::Internet.user_name
  email = Faker::Internet.email
  password = "password"
  Faker::Config.locale = 'en-US'
  phonenumber = "#{Faker::PhoneNumber.area_code}#{Faker::PhoneNumber.exchange_code}#{Faker::PhoneNumber.subscriber_number}"
  User.create!(username: name,
              email: email,
              phone_number: "#{phonenumber}",
              password:              password,
              password_confirmation: password)
end


# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }