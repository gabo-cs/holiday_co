# HolidayCo

The HolidayCo Gem is a simple Ruby library that simplifies the handling of holidays in Colombia. It provides a straightforward way to:

* Determine whether a specific date is a holiday in Colombia.
* Retrieve a list of all holidays in a given year.
* Access holiday names and dates.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'holiday_co'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install holiday_co

## Usage

Check if a specific date is a holiday.

```ruby
date = Date.new(2023, 12, 25)
if HolidayCo.is_holiday?(date)
  puts "#{date} is a holiday in Colombia!"
end
```

The argument can be a String, too.
```ruby
if HolidayCo.is_holiday?("2024-01-01")
  puts "¡Feliz Año Nuevo!"
end
```

If no date is provided, the gem will automatically default to today's date.
```ruby
if HolidayCo.is_holiday?
  puts "Today is a holiday in Colombia!"
end
```

You can also use the `holiday?` alias.
```ruby
if HolidayCo.holiday?(Date.tomorrow)
  puts "What time is the party tomorrow?"
end

# `Date.tomorrow` is a Rails method
```

List holidays for a specific year.
```ruby
year = 2023
holidays = HolidayCo.holidays(year)
puts "Holidays in #{year}:"
holidays.each do |holiday|
  puts "#{holiday[:date]}: #{holiday[:name]}"
end
```

If no year is provided, the gem will automatically default to the current year.
```ruby
HolidayCo.holidays.first[:date]
=> "2023-01-01" # Ran this on Sep 7th, 2023.
```

You can also retrieve holiday names and dates separately.
```ruby
HolidayCo.holidays_names(2023)
=> ["Año Nuevo", "Epifanía", "Día de San José", "Jueves Santo", "Viernes San...
```

```ruby
HolidayCo.holidays_dates(2023)
=> ["2023-01-01", "2023-01-09", "2023-03-20", "2023-04-06", "2023-04-07", "2...
```

## Contributing

Bug reports and pull requests are welcome on GitHub. This project is intended to be a safe, welcoming space for collaboration.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
