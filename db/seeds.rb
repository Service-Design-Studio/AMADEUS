# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user1 = User.new(
  :email => "admin123@admin.com",
  :password => "admin123",
  :password_confirmation => "admin123"
)
user1.save

user2 = User.new(
  :email => "admin456@admin.com",
  :password => "admin456",
  :password_confirmation => "admin456"
)
user2.save

user3 = User.new(
  :email => "admin789@admin.com",
  :password => "admin789",
  :password_confirmation => "admin789"
)
user3.save

topic_bank = %w[Tanks Artillery UAVs Helicopters Missiles MANPADs]
topic_bank.each do |topic|
  topic = Topic.new(:name => topic)
  topic.save
end