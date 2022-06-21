# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Article.create(
  title: 'Title 1',
  category: 'Category 1',
  summary: 'Summary 1',
  description: 'Description 1'
)

Article.create(
  title: 'Title 2',
  category: 'Category 2',
  summary: 'Summary 2',
  description: 'Description 2'
)

user1 = User.new(
  :email                 => "admin123@admin.com",
  :password              => "admin123",
  :password_confirmation => "admin123"
)
user1.save!

user2 = User.new(
  :email                 => "admin456@admin.com",
  :password              => "admin456",
  :password_confirmation => "admin456"
)
user2.save!

user3 = User.new(
  :email                 => "admin789@admin.com",
  :password              => "admin789",
  :password_confirmation => "admin789"
)
user3.save!

