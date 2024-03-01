# Project Details

## Objective

This project is a small application for payment validation, where the user enters the payment data and the application returns if it is a purchase with a risk of fraud.

## Configuração

This project runs on Ruby version 3.3 using Rails 7.1.3. If needed, you can use a version manager to facilitate this, like [ASDF](https://www.lucascaton.com.br/2020/02/17/instalacao-do-ruby-do-nodejs-no-ubuntu-linux-usando-asdf).

In this project, we are using PostgreSQL. If you need to change them to run on your local machine, you can do so in [database.yml](config/database.yml).

To execute the project, follow the steps below:

```console
$ bundle install
$ bin/rails db:create && db:migrate
$ bin/rails s
```

For testing, we used RSpec and the gems shoulda-matchers, database cleaner, Faker, and FactoryBot. If you want to execute the application tests, use the command below:

```console
$ bin/rails db:migrate RAILS_ENV=test
$ bundle exec rspec
```

For code quality and linter, we used the gems rubocop, rubocop-rails, rubocop-rspec, and rubocop-performance. You can execute them using the command below:

```console
$ bundle exec rubocop
```
