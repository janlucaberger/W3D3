# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
user_ids = []
users = []
10.times do
  user = User.create!(email: Faker::Internet.email)
  user_ids << user.id
  users << user
end

TagTopic.delete_all
tags = []
10.times do
  tag = TagTopic.create!(topic_name: Faker::Name.unique.name)
  tags << tag
end

ShortenedUrl.delete_all
urls = []
10.times do
  user = users.sample
  url = ShortenedUrl.shorten_url(user, Faker::Internet.domain_name)
  urls << url
end

Tagging.delete_all
10.times do
  Tagging.create!(topic_id: tags.sample.id, url_id: urls.sample.id)
end

Visit.delete_all
200.times do
  Visit.create!(user_id: users.sample.id, url_id: urls.sample.id)
end
