# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

collections = [["DVDs", "My DVD collection"], ["Books", "My Book collection"]]

items_one = ["Ocean's Eleven", "Skyfall", "Frozen", "Sherlock"]

items_two = ["Gone Girl", "To Kill a Mockingbird", "Life of Pi", "The Son"]

collections.each do |name, description|
  Collection.create!(name: name, description: description)
end

items_one.each do |name|
  Item.create!(name: name, collection_id: 1)
end

items_two.each do |name|
  Item.create!(name: name, collection_id: 2)
end
