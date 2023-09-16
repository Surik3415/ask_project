# frozen_string_literal: true

50.times do
  title = Faker::Hipster.sentence(word_count: 3)
  body = Faker::Lorem.sentences(number: 66, supplemental: true)
  Question.create(title: title, body: body)
end

User.find_each do |u|
  u.send(:set_gravatar_hash)
  u.save
end
