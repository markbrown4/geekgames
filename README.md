# Geek Games
Competition built for Sitepoint, a series of game with a leaderboard and prizes.

## Installation

Requires ruby 1.9.3 and openssl

```sh
gem install eventmachine -v 1.0.0 -- --with-cppflags=-I/usr/local/opt/openssl/include
bundle install
bundle exec rake db:setup
```

## Security for a game session

- limit amount of plays per account (e.g. only 3 per day)
- obscure js
- POST just changes at key intervals in game to server and generate outcomes / score server-side
- Check times, hash and valid x/y on server and return score
