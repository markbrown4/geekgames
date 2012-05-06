# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


g = Game.new(title: 'The 10cm Dash',  description: 'Be a straight shooter')
g.id = 1
g.save
g = Game.new(title: 'Mouseathalon',   description: 'Click those targets like a boss')
g.id = 2
g.save
g = Game.new(title: 'Ping Long',      description: 'Go head to head with a Pong Master')
g.id = 3
g.save

Page.create(
  title: 'Terms',
  slug: 'terms',
  body: ''
)

Page.create(
  title: 'Privacy',
  slug: 'privacy',
  body: ''
)

Page.create(
  title: 'Rules',
  slug: 'rules',
  body: ''
)