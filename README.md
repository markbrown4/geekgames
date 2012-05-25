# Geek Games

Competition built for Sitepoint, a series of game with a leaderboard and prizes.

## Deployment to Heroku
git remote add heroku git@heroku.com:young-galaxy-2891.git

http://young-galaxy-2891.heroku.com/

## Security for a game session

Some ideas

- limit amount of plays per account (e.g. only 3 per day)
- obscure js
- Init game with a unique hash and pass it with all data sent to the server
- POST just changes at key intervals in game to server and generate outcomes / score server-side
- Check times, hash and valid x/y on server and return score

Pong - when ball is at edge.
post
  hash: '3kh3f2h39723425'
  time: ms
  x: 120
  y: 500

mouseathalon - Every second ?
post
  hash: '3kh3f2h39723425'
  time: ms
  x: 120
  y: 500

Click and shoot - When you shoot

post
  hash: '3kh3f2h39723425'
  time: ms
  x: 120
  y: 500