
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

Page.create(
  title: 'Play to win',
  slug: 'home',
  body: "Join in the fun and compete with geeks, techies and web devs around the world
  - as you play 3 online games to WIN a [INSERT PRIZE HERE] -
  and qualify for DISCOUNTS of up to 90% on SitePoint books and more."
)



u = User.new(
  username: 'markbrown4',
  email: 'markbrown4@gmail.com',
  password: 'MM2kFTW',
  password_confirmation: 'MM2kFTW'
)
u.admin = true
u.save

u = User.new(
  username: 'tonydossantos',
  email: 'tony@juicegroup.com.au',
  password: 'MM2kFTW',
  password_confirmation: 'MM2kFTW'
)
u.admin = true
u.save