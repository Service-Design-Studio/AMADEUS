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

topic_bank = ["Tanks", "Artillery", "UAVs", "Fighter/Bomber Aircraft", "Helicopters", "Missles", "MANPADs", "Infrastructure damage/strike"]
topic_bank.each do |topic|
  topic = Topic.new(:name => topic)
  topic.save
end

# topic1 = Topic.new(
#   :name => "topic1",
#   :id =>60,
# )
# topic1.save!

# topic2 = Topic.new(
#   :name => "topic2",
#   :id =>61,
# )
# topic2.save!

# uploadlink1 = Uploadlink.new(
#   :upload_id => 1,
#   :topic_id => 60,
# )
# uploadlink1.save!

# uploadlink2 = Uploadlink.new(
#   :upload_id => 1,
#   :topic_id => 61,
# )
# uploadlink2.save!

# topic3 = Topic.new(
#   :name => "topic3",
#   :id =>62,
# )
# topic3.save!

# topic4 = Topic.new(
#   :name => "topic4",
#   :id =>63,
# )
# topic4.save!

# uploadlink3 = Uploadlink.new(
#   :upload_id => 1,
#   :topic_id => 62,
# )
# uploadlink3.save!

# uploadlink4 = Uploadlink.new(
#   :upload_id => 1,
#   :topic_id => 63,
# )
# uploadlink4.save!
