5.times do
User.create({
    email: Faker::Internet.free_email,
    password: Faker::Internet.password(8),
    token: Faker::Pokemon.name
  })
end
