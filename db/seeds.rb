require "faker"

case Rails.env
when "development"

  # First create two users!
 
  (1..15).each do |id|
    Category.create(
      id: id,
      name: Faker::Job.unique.field,
      description: Faker::Company.catch_phrase,
      ctype: 1,
      user_id: Faker::Number.between(from: 1, to: 2),
    )
  end

  (16..50).each do |id|
    Category.create(
      id: id,
      name: Faker::Food.unique.dish,
      description: Faker::GreekPhilosophers.quote,
      ctype: 0,
      user_id: Faker::Number.between(from: 1, to: 2),
    )
  end
  
  (1..250).each do |id|
    Operation.create(
      id: id,
      amount: Faker::Number.between(from: 1000, to: 15000),
      odate: Faker::Date.between(from: (Date.today - 365), to: Date.today),
      description: Faker::TvShows::DrWho.quote,
      category_id: Faker::Number.between(from: 1, to: 15),
      otype: 1,
      user_id: Faker::Number.between(from: 1, to: 2),
    )
  end

  (251..3500).each do |id|
    Operation.create(
      id: id,
      amount: Faker::Number.decimal(l_digits: 3, r_digits: 1),
      odate: Faker::Date.between(from: (Date.today - 365), to: Date.today),
      description: Faker::TvShows::Simpsons.quote,
      category_id: Faker::Number.between(from: 16, to: 50),
      otype: 0,
      user_id: Faker::Number.between(from: 1, to: 2),
    )
  end

when "production"

  # First create one user!

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
