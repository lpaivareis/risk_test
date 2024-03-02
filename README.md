# Project Details

## Objective

This project is a small application for payment validation, where the user enters the payment data and the application returns if it is a purchase with a risk of fraud.

## Starting the project

This project runs on Ruby version 3.3 using Rails 7.1.3. But don't worry, just have docker installed on your machine and you'll be able to run it with just a few commands.


```console
$ docker-compose build
$ docker-compose up
```

Before running the above commands, make sure the `docker-compose up` command is running.

For testing, we used RSpec and the gems shoulda-matchers, database cleaner, Faker, and FactoryBot. If you want to execute the application tests, use the command below:

```console
$ docker-compose exec web bundle exec rspec
```

For code quality and linter, we used the gems rubocop, rubocop-rails, rubocop-rspec, and rubocop-performance. You can execute them using the command below:

```console
$ docker-compose exec web bundle exec rubocop
```
