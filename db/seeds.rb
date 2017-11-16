# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [ {username: "Xin Qin", email: "qinxin@berkeley.edu", password: "123456", building: "CZ"},
          {username: "Ting An Yen", email: "fad11204@berkeley.edu", password: "123456", building: "Northside"},
          {username: "Christopher Hamilton", email: "cshamilton@berkeley.edu", password: "123456", building: "Davis"},
          {username: "Kevin Liu", email: "softandcozy@berkeley.edu", password: "123456", building: "CZ"},
          {username: "Tze Yang Ng", email: "tng016@berkeley.edu", password: "123456", building: "Northside"},
          {username: "Spencer McCall", email: "smccall@berkeley.edu", password: "123456", building: "Davis"},
          {username: "Oski", email: "oski@berkeley.edu", password: "123456", building: "CZ"},
          {username: "Chancellor Christ", email: "christ@berkeley.edu", password: "123456", building: "Davis"}]

users.each do |user|
  User.init(user[:username], user[:email], user[:password], user[:building])
end

User.find_by_username("Oski").promote("Manager")
User.find_by_username("Chancellor Christ").promote("Admin")
