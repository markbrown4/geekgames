
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

u = User.new(
  username: 'markbrown4',
  email: 'markbrown4@gmail.com',
  password: 'MM2kFTW',
  password_confirmation: 'MM2kFTW'
)
u.admin = true
u.save