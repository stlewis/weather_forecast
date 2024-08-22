# README

## Description

This project is a Rails application that allows users to input an address and get back current weather information and a 5 day forecast for the location they entered. The application uses external APIs from OpenWeatherMap and Google Maps to retrieve the weather and location data.

Information provided includes:

### Current Weather

* Current actual and "feels like" temperature.
* Current humidity
* Current wind speed and direction
* Current UV Index
* Sunrise and sunset times

### Forecast

* High and low temperatures
* Weather summary, (clear skies, cloudy, etc)
* Morning, evening, and night temperatures
* UV Index
* Humidity
* Wind speed and direction
* Sunrise and sunset times

## Installation & Configuration

### Secure Credentials

This application stores secure credentials for OpenWeatherMap and Google Address Validation APIs in the `config/credentials.yml.enc` file. The `master.key` file needed to decrypt this file is not included in this repository, so the simplest way to get started would be to recreate the `config/credentials.yml.enc` file with these contents:

```yaml
google:
  api_key: 'YOUR_API_KEY'

open_weather:
  api_key: 'YOUR_API_KEY'
```

Then encrypt the file with your own master key, located at `config/master.key`.

#### OpenWeatherMap Credentials

You can sign up for an OpenWeatherMap API key [here](https://home.openweathermap.org/users/sign_up). Once you've signed up, you'll need to subscribe to their One Call API to get the data you need. The subscription is free for up to 1000 calls per day.

#### Google Credentials

You can sign up for a Google API key from the Google Cloud Console [here](https://console.cloud.google.com) . You'll need to create a project and enable the Address Validation API to get the data you need. The first $200 of usage is free each month.

### Running the Application

The application was built using Ruby 3.0.5 and Rails 7.0.8.4. You will need these versions installed locally to get things running. Provided you have them installed, you can clone the repository, bundle install, and run the server to get started.

## Usage

The application is a fairly straightforward "monolith" that leverages standard ERB templates and Stimulus.js on the front end to provide a simple user interface. The user enters an address in the form provided, and the application uses the combination of the OpenWeatherMap and Google APIs to retrieve the weather and location data. The data is then displayed on the page in a user-friendly format.

Weather results are cached for 30 minutes to prevent unnecessary API calls. The cache is stored in memory and is not persisted between server restarts. Location data is also cached more aggressively to prevent unnecessary API calls. When a weather result is fetched from the cache, the interface is updated to reflect that the data is cached.

## Architecture and Design

The application mostly follows a standard Rails MVC pattern, with the exception that there are actually no models/database persistence present within it. Instead, the application relies on object wrappers around the external API data, which are then cached as described above, and used to populate the views.

There's definitely an argument to be made that some of the data, (notably normalized addresses), could be persisted to a database to reduce the number of API calls needed. However, in a real-world scenario, I felt that persisting data permanently that may only ever be needed a handful of times would end up being more cost-prohibitive than just periodically repeating the API calls.

Beyond the obvious controller/action structure, the application relies on two "local gems" to handle the API calls and data normalization. These are located in the `app/lib` directory and are autoloaded by Rails. The `/app/lib/open_weather` and `/app/lib/address_validation` directories contain the classes that handle the API calls and data normalization for the OpenWeatherMap and Google Address Validation APIs, respectively. Configuration files for each are found in `/config/initializers`.

### OpenWeather

The OpenWeather "local gem" is a simple wrapper around the OpenWeatherMap One Call and Geocoding APIs. However, rather than exposing these APIs directly to the controllers, the gem abstracts the API calls and data normalization into a single class with a static method `weather_for` providing an interface into the library's functionality. The `weather_for` method takes a zip code for the purpose of getting back geocoded coordinates and then fetching the weather data for that location.

The return value of the `weather_for` method is a Hash containing the current weather and forecast data for the location provided, under the keys `current_weather` and `forecast` respectively.

#### OpenWeather::WeatherData

The `OpenWeather::WeatherData` class is an abstract parent class that defines the attributes that both the `OpenWeather::CurrentWeather` and `OpenWeather::Forecast` classes share. It also contains a helper method to determine wind direction from data provided by the OpenWeatherMap API.

#### OpenWeather::CurrentWeather

The `OpenWeather::CurrentWeather` class is a subclass of `OpenWeather::WeatherData` that normalizes the current weather data returned by the OpenWeatherMap API. It also provides a method for summarizing the current weather data in a human-readable format.

#### OpenWeather::Forecast

The `OpenWeather::Forecast` class is a subclass of `OpenWeather::WeatherData` that normalizes the forecast data returned by the OpenWeatherMap API for a single day. It is primarily a data container and does not contain any additional logic. The `weather_for` method in the `OpenWeather` module is responsible for creating instances of this class for each day in the forecast.

### Address Validation

The Address Validation "local gem" is designed similarly to the OpenWeather gem, with a single class providing an interface to the Google Address Validation API through a static method `standardize_address`. The `standardize_address` method takes a hash containing the components of the address, (`street`, `city`, `state`, `zip_code`), and returns a normalized address object, (really an OpenStruct), containing the address components returned by the Google API.

The API call is wrapped by the `AddressValidation::Api::Base` class, which contains a single method `validate_address` that makes the API call and returns the response.

## Error Handling

The application has basic error handling in place for the most common issues that might arise when making API calls. If the user enters an address that cannot be geocoded, they will be presented with an error message. If the external APIs return an error, the user will be presented with a message indicating that the weather data could not be retrieved.

These errors are generated at the library level and are passed back to the controller for display to the user. The application does not log these errors, but in a production environment, my strategy would be to leverage something like Sentry to capture and log these errors for later analysis.

The controller also handles basic input validation errors, that might normally be passed off to models in an application that had them. I did briefly consider using something like `dry-validation` to handle this, but ultimately decided that the simplicty of the validation rules didn't justify the additional overhead.

## Testing

The application has a suite of RSpec tests that cover the controller, libraries, routes, and so on.
