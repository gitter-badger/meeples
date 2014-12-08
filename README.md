Meepl.es [![build status][ci-image]][ci] [![code quality][cq-image]][cq] [![code quality][cc-image]][cq]
========================================================================================================

![rails rumble 2014][rr-image]

Track the games you play.

### Environment Variables

In development & test, environment variables are loaded from `.env`

  - **EMAIL_HOST**: hostname to use in email links
  - **SECRET_TOKEN**: secret token for rails
  - **UNICORN_WORKERS**: number of unicorn workers to start

#### Omniauth Providers

  - **FACEBOOK_APP_ID**
  - **FACEBOOK_SECRET**
  - **GITHUB_APP_ID**
  - **GITHUB_SECRET**

## Development

### Prerequisites

- ruby 2.0.0+   # rvm install 2.1.3
- bundler
- mysql         # brew install mysql
- postgresql    # http://postgresapp.com

```bash
$ git clone git@github.com/devfu/base.git
$ cd base
$ bundle
$ cp {sample,}.env                  # edit this file
$ cp Procfile.local{.sample,}       # edit this file
$ cp config/database.yml{.sample,}  # edit this file
$ bundle exec rake db:setup
$ bundle exec rake spec
$ foreman start -f Procfile.local
```

## Testing

### Prerequisites

- phantomjs # brew install phantomjs
- redis     # brew install redis

Tools used:

- rspec
- capybara
- factory girl
- poltergeist

```bash
rake spec # this will run all of the RSpec specifications, located in ./spec
```

- Specs are organized into model & feature specs (/spec/models, /spec/features)
- Factories are located in /spec/factories.rb

## Deploy

Recommended deployment is via [Heroku](http://heroku.com). They have an excellent intro at http://docs.heroku.com/quickstart

### Addons

We're using the following heroku addons

- deployhooks
- heroku-postgresql:hobby
- memcachier
- newrelic
- papertrail
- pgbackups
- rediscloud
- rollbar
- sendgrid

### Environment Variables

Use the heroku config command to check/set environemnt variables on Heroku.

<!-- links -->
[ci]: https://magnum.travis-ci.com/devfu/meeples "build status"
[cq]: https://codeclimate.com/repos/5484fa96e30ba0250200b759/feed "code quality"

<!-- images -->
[cc-image]: https://codeclimate.com/repos/5484fa96e30ba0250200b759/badges/d6720e7d188940094cba/coverage.png
[ci-image]: https://magnum.travis-ci.com/devfu/meeples.svg?token=hzo1TAdp6KbDZRs4Cjfs&branch=master
[cq-image]: https://codeclimate.com/repos/5484fa96e30ba0250200b759/badges/d6720e7d188940094cba/gpa.svg
[rr-image]: https://d4nnn7wspfa3h.cloudfront.net/rails-rumble-badge-2014-sm.png
