# Admin of goldenowl.asia

Admin panel of `goldenowl.asia`. Includes crud panels and resful api for clients, blogs, careers, ...

[![CircleCI](https://circleci.com/gh/GoldenOwlAsia/admin.goldenowl.asia.svg?style=shield)](https://circleci.com/gh/GoldenOwlAsia/admin.goldenowl.asia)
[![Maintainability](https://api.codeclimate.com/v1/badges/dafecd84f9b151dc1e37/maintainability)](https://codeclimate.com/github/GoldenOwlAsia/admin.goldenowl.asia/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/dafecd84f9b151dc1e37/test_coverage)](https://codeclimate.com/github/GoldenOwlAsia/admin.goldenowl.asia/test_coverage)

## General Information

- Ruby version: `ruby 2.6.6`
- Rails version: `rails 6.0.2`
- Database: `postgresql`

## Quick Start

1. Make sure that you have installed ruby, rails and postgresql. Read [this guide](https://gorails.com/setup) to install if you don't have.
2. Clone this repo using `git clone git@github.com:GoldenOwlAsia/admin.goldenowl.asia.git`
3. Move to the appropriate directory: `cd admin.goldenowl.asia`
4. Install correct ruby version for our project. If you have `rbenv`, use these commands:

```
rbenv install 2.6.6
rbenv local 2.6.6
```

5. Install bundler: `gem install bundler`
6. Install gems: `bundle install`
7. Add database config: create `config/database.yml` file (refer from `config/database.yml.example`)
8. Add environment variables: create `.env` file (refer from `.env.example`)
9. Database setup: `bundle exec rake db:setup`
10. Start server: `rails s`
11. Visit `http://localhost:3000` and start your development

## Testing

1. Start to run your specs by: `bundle exec rspec`
2. See coverage by open `coverage/index.html` in web browser
