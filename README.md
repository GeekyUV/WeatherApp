
# Weather App

Welcome to the Weather App! This is a Ruby on Rails application that allows you to search for weather conditions The app uses Ruby version 3.2.2 and Rails version 7.0.7

## Features
- user can sign up and login
- once logged in user can surf throgh cities to check weather conditions

### Api 
- the app retrieves weather data from                     https://openweathermap.org/api create account here to get your api Key


# Getting Started

- clone the repository

```bash
git clone https://github.com/GeekyUV/WeatherApp.git

```

- installed the required gem(note that no gem is used for authentication gems here are for api integration and rspec tests)
```
bundle install
```

- Setup the database
```
rails db:create
```
```
rails db:migrate
```

setup your api credentials 
- replace your api key in app/controllers/welcome_controller.rb

- start the server


```
rails s
``` 
check test cases

- run this command
```
bundle exec rspec 
```
- all test cases are covered to check coverage run the following command in app directory

```
 open coverage/index.html
```


#### you are ready to go! explore the app
- this is is basic implementation this project can be expanded and can have more complex features that would be provided in another version


### Guide to Rspec installation 
- add these in your gemfile.rb
```
gem 'rspec-rails'
gem 'simplecov', require: false
gem 'rails-controller-testing' #for assert template
```
-run bundle install to install dependencies
```
bundle install
```
- install rspec run this command to add spec folder in which we will write test cases 
```
rails generate rspec:install
```

- Create spec files for your controllers, models, and any other components you want to test. For example, you can create a spec file for your controller name yuvicontroller then spec file name would be yuvicontroller_spec.rb

- run bundle exec rspec to run test files
- to check covergae open coverage/index.html

#### Happy learning! :)





