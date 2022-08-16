# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(
  [
    { email: "admin123@admin.com", password: "admin123", password_confirmation: "admin123" },
    { email: "admin456@admin.com", password: "admin456", password_confirmation: "admin456" },
    { email: "admin789@admin.com", password: "admin789", password_confirmation: "admin789" }
  ])

category_bank = %W[Tanks Artillery UAVs Helicopters Missiles MANPADs #{"Fighter Aircraft"} #{"Infrastructure Strike"}]
category_bank.each do |category_name|
  Category.create(:name => category_name)
end