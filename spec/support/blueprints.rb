require 'machinist/active_record'

User.blueprint do
  username  { Faker::Name.name }
  email { "email_#{sn}@mydomain.com" }
  password { "password" }
  password_confirmation { object.password }
end

User.blueprint(:admin) do
  username { "Admin" }
  email { "admin@email.com" }
end

Game.blueprint do
  title      { Faker::Name.name }
  description { "Not for the faint of heart." }
end