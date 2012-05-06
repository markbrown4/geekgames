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
  #is_admin { true }
end

Page.blueprint do
  body { "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." }
end