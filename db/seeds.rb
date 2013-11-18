# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
#


(1..10).each do |id|
  Book.create(title: Faker::Lorem.words(5).join(" "),
              author: Faker::Lorem.words(2).join(" "),
              publisher: Faker::Lorem.words(2).join(" "),
              price: Faker.numerify("##.##") )

  User.create(first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email)
end

User.create(first_name: 'Rajat',
            last_name: 'Agrawal',
            email: 'rajat@library.casecommons.org',
            password: 'Password123',
            role: 'admin')
