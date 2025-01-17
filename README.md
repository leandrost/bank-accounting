## Bank Accounting 
[![forthebadge](https://forthebadge.com/images/badges/made-with-ruby.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com)

Bank Accounting transfers manager API exercise using [json:api specification](https://jsonapi.org/)

## Requirements

- Ruby 2.7
- Postgres 12

## Getting started

1. Clone this repo:
```
git clone git@github.com:leandrost/bank-accounting.git
cd bank-accounting
```

2. Setup the application:
```
bundle config --local path vendor # optional - config bundler to locally install gems on ./vendor
bin/setup
```

3. Seed the database:
```
bin/rails db:seed
```

4. Run the application:
```
bin/rails server
```

## Tests

```
bin/rspec
```

## Deploy

```
git push heroku master
```

## Structure

- **app/models** - Classes that model and wrap the data stored in the database
- **app/controllers** - Handle API requests running the business logic operations
- **app/serializers** - Defines resource attributes to be serialized on resonses
- **app/services** - Operations related to the business logic
- **app/types** - Define custom attributes types

## Usage

https://documenter.getpostman.com/view/10922429/SzYYzyQd?version=latest

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b feature/my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin feature/my-new-feature`)
5. Create new Pull Request

## TODO

- Add User Authentication
- Add timestamps into API responses
- Include relationships on some responses

