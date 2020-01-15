# Sweater Weather

## Description

Sweater Weather is a backend API that provides weather data and user authentication for a fictional frontend user interface. Endpoints for the API use the Google Maps API to provide latitude and longitude of search locations, the Dark Sky API to get current and forecast weather information, and the Unsplash API to get background photos for the queried location. This information is all then packaged and returned as serialized JSON for frontend consumption.

## Purpose

The purpose of this project was to build an API that could consume data from a number of various sources and then package as JSON 1.0 compliant package for a frontend to present to users.

## Focus Areas

* Consuming a number of various APIs
* Building Authenticated API calls
* Building features on Greenfield Code
* Test driven development
* Work with a deadline
* Prioritizing code functionality vs best practices

## APIs Used
* [Google Maps API](https://developers.google.com/maps/documentation)
* [Dark Sky Weather API](https://darksky.net/dev)
* [Dark Sky Weather API](https://unsplash.com/developers)

## Tech/Framework Used

Sweater Weather is written in Ruby with Ruby On Rails, uses a postgresql database, and is hosted on Heroku with the Travis CI integration tool and Skylight task integration.

### Gems
The following Ruby Gems are used in this project:

* [faraday](https://github.com/lostisland/faraday)
* [figaro](https://github.com/laserlemon/figaro)
* [capybara](https://github.com/teamcapybara/capybara)
* [vcr](https://github.com/vcr/vcr)
* [webmock](https://github.com/bblimke/webmock)
* [simple cov](https://github.com/colszowka/simplecov)
* [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)
* [skylight](https://www.skylight.io/)

## Database

### Database Setup

#### Local Environment
  - `bundle exec rake db:create`
  - `bundle exec rake db:migrate`
  - `bundle exec rake db:seed`

## Testing

### Running Tests
  - You can run the full testing suite with the command `bundle exec rspec`

  - You can run an individual test using `bundle exec rspec <path-to-file>`

### Using Fiagro in development and testing
Keep environment variables secure by using Figaro to generate an `application.yml` file. See more information about using the figaro gem at https://github.com/laserlemon/figaro.

### Required Environment Variables
Environment variables and required API keys/tokens (in Figaro format) :
1. Google Geocode API key defined as `ENV['GOOGLE_GEOCODE_API_KEY']`
1. Darky Sky API key defined as `ENV['DARK_SKY_API_KEY']`
1. Unsplash API key defined as `ENV['UNSPLASH_API_KEY']`
1. Antipode API key defined as `ENV['ANTIPODE_API_KEY']`

### Refreshing VCR Test Cassettes
From time to time you may receive an error when testing with the VCR. You can delete the cassettes directory from your `spec` folder and run `bundle exec rspec` to refresh the cassettes used. More information on VCR cassettes can be found in the [VCR documentation](https://github.com/vcr/vcr).

## Versions
- Ruby 2.4.1
- Rails 5.2.4