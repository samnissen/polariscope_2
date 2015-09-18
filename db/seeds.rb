# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

relationships = [
  { :relation => 'parent' },
  { :relation => 'child' }, # http://stackoverflow.com/questions/16994290/get-collection-of-child-nodes-in-watir-webdriver
  { :relation => 'preceding_sibling'}, # https://jkotests.wordpress.com/2013/08/21/locate-a-sibling-from-a-watir-element/
  { :relation => 'following_sibling'} # https://jkotests.wordpress.com/2013/08/21/locate-a-sibling-from-a-watir-element/
]

relationships.each do |attributes|
  SiblingRelationship.find_or_initialize_by(relation: attributes[:relation]).tap do |t|
    t.save!
  end
end
