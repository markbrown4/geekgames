
g = Game.new(
  title: 'MOUSE-QUESTRIAN',
  description: 'See how **FAST and ACCURATELY,** you can trace the line from start to finish.
On your Marks... Get set... Go!'
)
g.id = 1
g.save
g = Game.new(
  title: 'SPAM-SHOOT',
  description: '**Hate spam?** Vent your frustration and shoot as many spam emails as you can.
Ready... Aim... Fire!'
)
g.id = 2
g.save
g = Game.new(
  title: 'PONG LONG',
  description: 'Out-last the computer in a **game of pong.**
Ready... Steady... Serve!'
)
g.id = 3
g.save

Page.create(
  title: 'Terms',
  slug: 'terms',
  body: ''
)

Page.create(
  title: 'Play to win',
  slug: 'home',
  body: "Join in the fun and compete with geeks, techies and web devs around the world
as you play 3 online games to **WIN an iPad and MacBook Air, Amazon Kindles**
and qualify for **DISCOUNTS of up to 100%** on SitePoint books and more."
)

u = User.new(
  username: 'bob',
  email: 'bob@gmail.com',
  password: 'password1',
  password_confirmation: 'password1',
  country: 'au'
)
u.admin = true
u.save
