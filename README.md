# Geek Games
Competition built for Sitepoint, a series of game with a leaderboard and prizes.

## Installation

Requires ruby 1.9.3 and openssl

```sh
gem install eventmachine -v 1.0.0 -- --with-cppflags=-I/usr/local/opt/openssl/include
bundle install
bundle exec rake db:setup
```

## Deployment
http://games.sitepoint.com/  
git remote add production git@heroku.com:sitepoint-geekgames.git

http://geek-games-staging.herokuapp.com/  
git remote add staging git@heroku.com:geek-games-staging.git

## Git workflow
### Push changes to github
git pull origin master  
git push origin master

### Deploy to staging
git push staging master

### Deploy to production
git push production master

## Security for a game session

- limit amount of plays per account (e.g. only 3 per day)
- obscure js
- POST just changes at key intervals in game to server and generate outcomes / score server-side
- Check times, hash and valid x/y on server and return score
