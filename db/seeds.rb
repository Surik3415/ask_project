50.times do
  title = Faker::Hipster.sentence(word_count: 3)
  body = Faker::Lorem.sentences(number: 66, supplemental: true)
  Question.create(title: title, body: body)
end
