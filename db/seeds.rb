# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.where(email: 'admin@testing.com').first_or_create do |admin|
  admin.admin                 = true
  admin.password              = 'testing!'
  admin.password_confirmation = 'testing!'
  admin.skip_confirmation!
end
