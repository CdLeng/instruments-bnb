# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "faker"

users_created = 0
instrument_categories_created = 0
instruments_created = 0
reviews_created = 0
bookings_created = 0

categories = ['Electric guitar', 'Classic guitar', 'Bass', 'Piano', 'Saxophone', 'Drums', 'Violin', 'Trumpet', 'Ukelele', 'Flute']

created_categories = []
categories.each do |category_name|
  category = InstrumentCategory.new do |instcat|
    instrument_categories_created += 1
    instcat.category = category_name
    instcat.created_at = Faker::Date.backward(days: 14)
    instcat.updated_at = Faker::Date.backward(days: 14)
  end

  puts category_name
  category.save!


  created_categories.push(category)
end

for i in (1..5)
  user = User.new do |u|
    users_created += 1
    u.email = Faker::Internet.email
    u.password = Faker::Internet.password
    u.created_at = Faker::Date.backward(days: 14)
    u.updated_at = Faker::Date.backward(days: 14)
  end
  user.save!

  for i in (1..2)
    instrument = Instrument.new do |inst|
      instruments_created += 1
      inst.instrument_category = created_categories.sample
      inst.user = user
      inst.name = Faker::Lorem.sentence(word_count: 3)
      inst.description = Faker::Lorem.paragraph
      inst.address = Faker::Address.full_address
      inst.price = Faker::Number.between(from: 50, to: 300)
      inst.created_at = Faker::Date.backward(days: 14)
      inst.updated_at = Faker::Date.backward(days: 14)

    end
    instrument.save!

    for i in (1..2)
      booking = Booking.new do |book|
        bookings_created += 1
        book.user = user
        book.date_start = Faker::Date.backward(days: 8)
        book.date_end = Faker::Date.backward(days: 4)
        book.total_price = Faker::Number.between(from: 80, to: 300)
        book.instrument = instrument
        book.created_at = Faker::Date.backward(days: 14)
        book.updated_at = Faker::Date.backward(days: 14)
      end
      booking.save!
    end

    for i in (1..2)
      review = Review.new do |rev|
        reviews_created += 1
        rev.user = user
        rev.instrument = instrument
        rev.created_at = Faker::Date.backward(days: 14)
        rev.updated_at = Faker::Date.backward(days: 14)
        rev.rate = Faker::Number.between(from: 1, to: 5)
        rev.content = Faker::Restaurant.review[0, 400]
      end
      review.save!
    end
  end

end

puts "#{users_created} users were created (total: #{User.all.count})"
puts "#{instrument_categories_created} categories were created (total: #{InstrumentCategory.all.count})"
puts "#{instruments_created} instruments were created (total: #{Instrument.all.count})"
puts "#{reviews_created} reviews were created (total: #{Review.all.count})"
puts "#{bookings_created} bookings were created (total: #{Booking.all.count})"
