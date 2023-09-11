# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "faker"

case Rails.env
when "development"
  
  (1..15).each do |id|
    Category.create(
      id: id,
      name: Faker::Job.unique.field,
      description: Faker::Company.catch_phrase,
      ctype: 1,
    )
  end

  (16..50).each do |id|
    Category.create(
      id: id,
      name: Faker::Food.unique.dish,
      description: Faker::GreekPhilosophers.quote,
      ctype: 0,
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
    )
  end

when "production"

  (1..10).each do |id|
    Category.create(
      id: id,
      name: Faker::ElectricalComponents.unique.active,
      description: Faker::Movies::StarWars.quote,
      ctype: 1,
    )
  end

  (11..20).each do |id|
    Category.create(
      id: id,
      name: Faker::ElectricalComponents.unique.passive,
      description: Faker::Movies::VForVendetta.quote,
      ctype: 0,
    )
  end

  (1..20).each do |id|
    Operation.create(
      id: id,
      amount: Faker::Number.between(from: 1000, to: 10000),
      odate: Faker::Date.between(from: (Date.today - 31), to: Date.today),
      description: Faker::TvShows::DrWho.quote,
      category_id: Faker::Number.between(from: 1, to: 10),
      otype: 1,
    )
  end

  (21..200).each do |id|
    Operation.create(
      id: id,
      amount: Faker::Number.decimal(l_digits: 3, r_digits: 1),
      odate: Faker::Date.between(from: (Date.today - 31), to: Date.today),
      description: Faker::TvShows::Simpsons.quote,
      category_id: Faker::Number.between(from: 11, to: 20),
      otype: 0,
    )
  end

end
