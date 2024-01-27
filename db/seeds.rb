require "faker"

case Rails.env
when "development"

  user = User.where(email: "first@theCatCried.com").first_or_initialize
  user.update!(
      username: "First",
      password: "password",
      password_confirmation: "password"
  )

  user = User.where(email: "second@theCatCried.com").first_or_initialize
  user.update!(
      username: "Second",
      password: "password",
      password_confirmation: "password"
  )
 
  (1..10).each do |id|
    Category.create(
      id: id,
      name: Faker::Job.unique.field,
      description: Faker::Company.catch_phrase,
      ctype: 1,
      user_id: 1,
    )
  end

  (11..20).each do |id|
    Category.create(
      id: id,
      name: Faker::Book.unique.title,
      description: Faker::Movies::HarryPotter.quote,
      ctype: 1,
      user_id: 2,
    )
  end

  (21..35).each do |id|
    Category.create(
      id: id,
      name: Faker::Food.unique.dish,
      description: Faker::GreekPhilosophers.quote,
      ctype: 0,
      user_id: 1,
    )
  end

  (36..50).each do |id|
    Category.create(
      id: id,
      name: Faker::Hobby.unique.activity,
      description: Faker::Movies::StarWars.quote,
      ctype: 0,
      user_id: 2,
    )
  end
  
  (1..125).each do |id|
    Operation.create(
      id: id,
      amount: Faker::Number.between(from: 1000, to: 15000),
      odate: Faker::Date.between(from: (Date.today - 365), to: Date.today),
      description: Faker::TvShows::Friends.quote,
      category_id: Faker::Number.between(from: 1, to: 10),
      otype: 1,
      user_id: 1,
    )
  end

  (126..250).each do |id|
    Operation.create(
      id: id,
      amount: Faker::Number.between(from: 1000, to: 15000),
      odate: Faker::Date.between(from: (Date.today - 365), to: Date.today),
      description: Faker::TvShows::DrWho.quote,
      category_id: Faker::Number.between(from: 11, to: 20),
      otype: 1,
      user_id: 2,
    )
  end

  (251..1750).each do |id|
    Operation.create(
      id: id,
      amount: Faker::Number.decimal(l_digits: 3, r_digits: 1),
      odate: Faker::Date.between(from: (Date.today - 365), to: Date.today),
      description: Faker::TvShows::Stargate.quote,
      category_id: Faker::Number.between(from: 21, to: 35),
      otype: 0,
      user_id: 1,
    )
  end

  (1751..3500).each do |id|
    Operation.create(
      id: id,
      amount: Faker::Number.decimal(l_digits: 3, r_digits: 1),
      odate: Faker::Date.between(from: (Date.today - 365), to: Date.today),
      description: Faker::TvShows::Simpsons.quote,
      category_id: Faker::Number.between(from: 36, to: 50),
      otype: 0,
      user_id: 2,
    )
  end

when "production"

  user = User.where(email: "first@theCatCried.com").first_or_initialize
  user.update!(
      username: "First",
      password: "password",
      password_confirmation: "password"
  )

  (1..5).each do |id|
    Category.create(
      id: id,
      name: Faker::ElectricalComponents.unique.active,
      description: Faker::Movies::StarWars.quote,
      ctype: 1,
      user_id: 1,
    )
  end

  (6..15).each do |id|
    Category.create(
      id: id,
      name: Faker::ElectricalComponents.unique.passive,
      description: Faker::Movies::VForVendetta.quote,
      ctype: 0,
      user_id: 1,
    )
  end

  (1..20).each do |id|
    Operation.create(
      id: id,
      amount: Faker::Number.between(from: 1000, to: 10000),
      odate: Faker::Date.between(from: (Date.today - 31), to: Date.today),
      description: Faker::TvShows::DrWho.quote,
      category_id: Faker::Number.between(from: 1, to: 5),
      otype: 1,
      user_id: 1,
    )
  end

  (21..150).each do |id|
    Operation.create(
      id: id,
      amount: Faker::Number.decimal(l_digits: 3, r_digits: 1),
      odate: Faker::Date.between(from: (Date.today - 31), to: Date.today),
      description: Faker::TvShows::Simpsons.quote,
      category_id: Faker::Number.between(from: 6, to: 15),
      otype: 0,
      user_id: 1,
    )
  end

end
