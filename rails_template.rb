gem_group :development, :test do
  gem 'annotate'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end

gem_group :development do
  # QoL and code quality
  gem 'guard', require: false
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false
  gem 'rails-erd'  # generate ERD diagrams of DB
  gem 'rubocop', require: false

  # Security and maintenance
  gem 'brakeman', require: false # Rails Security Scanner
  gem 'bundler-audit', require: false # Patch-level verification for Bundler
  gem 'traceroute' # find dead routes and unused actions
end

after_bundle do
  generate 'rspec:install'
  generate 'annotate:install'

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
      TargetRubyVersion: 2.4

    Rails:
      Enabled: true

    Documentation:
      Enabled: false

    Metrics/BlockLength:
      Enabled: false

    Style/FrozenStringLiteralComment:
      Enabled: false
  CODE

  run 'guard init rspec rubocop'
  run 'touch .rubocop_todo.yml'
  run 'echo ".env" >> .gitignore'

  say 'Setup complete - please review Gemfile and other config files.'
  say 'Keep Shipping!'
end
