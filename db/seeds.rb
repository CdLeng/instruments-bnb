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

for i in (1..5)
  user = User.new do |u|
    users_created += 1
    u.email = Faker::Internet.email
    u.password = Faker::Internet.password
    u.created_at = Faker::Date.backward(days: 14)
    u.updated_at = Faker::Date.backward(days: 14)

    for i in (1..2)
      InstrumentCategory.new do |instcat|
        instrument_categories_created += 1
        instcat.category = Faker::Music.instrument
        instcat.created_at = Faker::Date.backward(days: 14)
        instcat.updated_at = Faker::Date.backward(days: 14)

        for i in (1..2)
          instrument = Instrument.new do |inst|
            instruments_created += 1
            inst.instrument_category = instcat
            inst.user = u
            inst.created_at = Faker::Date.backward(days: 14)
            inst.updated_at = Faker::Date.backward(days: 14)

            for i in (1..2)
              review = Review.new do |rev|
                reviews_created += 1
                rev.user = u
                rev.instrument = inst
                rev.created_at = Faker::Date.backward(days: 14)
                rev.updated_at = Faker::Date.backward(days: 14)
                rev.rate = Faker::Number.between(from: 1, to: 5)
                rev.content = Faker::Restaurant.review[0, 400]

                for i in (1..2)
                  booking = Booking.new do |book|
                    bookings_created += 1
                    book.user = u
                    book.date_start = Faker::Date.backward(days: 8)
                    book.date_end = Faker::Date.backward(days: 4)
                    book.total_price = Faker::Number.between(from: 80, to: 300)
                    book.instrument = inst
                    book.created_at = Faker::Date.backward(days: 14)
                    book.updated_at = Faker::Date.backward(days: 14)
                  end
                  booking.save!
                end
              end
              review.save!
            end
          end
          instrument.save!
        end
      end
    end
  end
  user.save!
end

puts "#{users_created} users were created (total: #{User.all.count})"
puts "#{instrument_categories_created} categories were (total: #{InstrumentCategory.all.count})"
puts "#{instruments_created} instruments were (total: #{Instrument.all.count})"
puts "#{reviews_created} reviews were (total: #{Review.all.count})"
puts "#{bookings_created} bookings were (total: #{Booking.all.count})"
