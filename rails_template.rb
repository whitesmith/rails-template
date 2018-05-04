gem_group :development, :test do
  gem 'annotate'
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'rspec-rails' # must also be on development group for generators to work
end

gem_group :development do
  gem 'letter_opener'
  gem 'listen'
  gem 'rack-livereload'

  # QoL and code quality
  gem 'guard', require: false
  gem 'guard-livereload', require: false
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false
  gem 'rails-erd'  # generate ERD diagrams of DB
  gem 'rubocop', require: false

  # Security and maintenance
  gem 'brakeman', require: false # Rails Security Scanner
  gem 'bundler-audit', require: false # Patch-level verification for Bundler
  gem 'foreman'
  gem 'traceroute' # find dead routes and unused actions
end

gem_group :test do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'launchy'
  gem 'rspec_junit_formatter' # for certain CI services
  gem 'simplecov', require: false
  gem 'webmock'
end

after_bundle do
  generate 'rspec:install'
  generate 'annotate:install'

  run 'rm REAME.md'
  file 'REAME.md', <<-CODE
# Title

TBD: short description

**Table of Contents**

- [Overview](#overview)
- [Getting Started](#getting-started)
- [Contributing](#contributing)
- [Testing](#testing)
- [Deploying](#deploying)
- [Contributors](#contributors)


## Overview

TBD

## Getting Started

Make sure you have Ruby and Yarn installed and run:
- `bundle install`
- `yarn install`
- `rails db:setup`
- `rails start`

Finally, copy `.env.example` into `.env` and fill in the necessary values.

## Contributing

Use `guard` to ease development and make sure tests are passing and your code
conforms to Ruby/Rails best practices.

Use these commands regularly to ensure there are no outstanding issues:

- `rubocop`: checks for code smells
- `brakeman`: runs security scanner
- `bundler-audit update && bundler-audit check`: verifies known vulnerable gems
- `rake erd`: generates ERD diagram of models
- `rake traceroute`: verifies unsused/unreachable endpoints

Do you work on a branch, and when ready open a pull request for review.
Try to keep PRs and commits small and focosed.

## Testing

Run `rspec` to test the entire suite.

Rspec provides many testing utilities, but we'll focus more on these:

- `spec/models`: unit tests for models and their relations
  + each model should have its own test specs
- `spec/requests`: integration tests for routes and controllers
  + each controler/action should have its own test specs
- `spec/features`: browser-level integration tests (full stack)
  + core features should have its own test specs

As usual:

- `spec/factories`: factory definitions for models
- `spec/fixtures`: files used during tests

## Deploying

TBD

### Rolling back a bad deployment

TBD

## Contributors

The current core team consists of members of [Whitesmith](https://github.com/whitesmith/):

* [Gervasio](mailto:gervasio@whitesmith.co)
* ...
  CODE

  file '.env.example', <<-CODE
SECRET_KEY_BASE=""
  CODE

  file '.rubocop.yml', <<-CODE
inherit_from: .rubocop_todo.yml

AllCops:
  Include:
    - '**/Gemfile'
  Exclude:
    - 'tmp/**/*'
    - 'vendor/**/*'
    - config/**/*
    - db/**/*
    - bin/**/*
    - node_modules/**/*
    - Rakefile
    - Guardfile
  TargetRubyVersion: 2.5

Rails:
  Enabled: true

Documentation:
  Enabled: false

Layout/EmptyLinesAroundBlockBody:
  Enabled: false

Layout/EmptyLinesAroundModuleBody:
  Enabled: false

Layout/EmptyLinesAroundClassBody:
  Enabled: false

Layout/EmptyLinesAroundMethodBody:
  Enabled: false

Metrics/BlockLength:
  Enabled: false

Style/EmptyMethod:
  Enabled: false

Style/FrozenStringLiteralComment:
  Enabled: false
  CODE

  run 'guard init rspec rubocop livereload'
  run 'touch .rubocop_todo.yml'
  run 'echo ".env" >> .gitignore'

  say 'Setup complete - please review Gemfile and other config files.'
  say 'Keep Shipping!'
end
