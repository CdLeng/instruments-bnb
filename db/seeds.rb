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

categories = [
  ['Electric guitar', 'https://images.unsplash.com/photo-1601956349578-c31521587860?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'],
  ['Classic guitar', 'https://images.unsplash.com/photo-1528553744039-c1dcef33574f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1763&q=80'],
  ['Bass', 'https://images.unsplash.com/photo-1601148072347-4c63fe45bd33?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'],
  ['Piano', 'https://images.unsplash.com/photo-1571974599782-87624638275e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2231&q=80'],
  ['Saxophone', 'https://images.unsplash.com/photo-1629907451365-6731862a0d32?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'],
  ['Drums', 'https://images.unsplash.com/photo-1602939444907-6e688c594a66?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2232&q=80'],
  ['Violin', 'https://images.unsplash.com/photo-1460036521480-ff49c08c2781?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8dmlvbGlufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60'],
  ['Trumpet', 'https://images.unsplash.com/photo-1511192336575-5a79af67a629?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2232&q=80'],
  ['Ukelele', 'https://images.unsplash.com/photo-1501731146954-20371d3b1afb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80'],
  ['Flute', 'https://images.unsplash.com/photo-1638317037996-f86e745cf657?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1774&q=80']
]

created_categories = []
categories.each do |category_and_image|
  category_name = category_and_image[0]
  category_image = category_and_image[1]

  category = InstrumentCategory.new do |instcat|
    instrument_categories_created += 1
    instcat.category = category_name
    instcat.image = category_image
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
