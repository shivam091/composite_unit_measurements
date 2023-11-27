# Composite Unit Measurements

A collection of specialized parsers designed for handling composite measurement strings.

[![Ruby](https://github.com/shivam091/composite_unit_measurements/actions/workflows/main.yml/badge.svg)](https://github.com/shivam091/composite_unit_measurements/actions/workflows/main.yml)
[![Gem Version](https://badge.fury.io/rb/composite_unit_measurements.svg)](https://badge.fury.io/rb/composite_unit_measurements)
[![Gem Downloads](https://img.shields.io/gem/dt/composite_unit_measurements.svg)](http://rubygems.org/gems/composite_unit_measurements)
[![Maintainability](https://api.codeclimate.com/v1/badges/94e13b43cdd19e6c462c/maintainability)](https://codeclimate.com/github/shivam091/composite_unit_measurements/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/94e13b43cdd19e6c462c/test_coverage)](https://codeclimate.com/github/shivam091/composite_unit_measurements/test_coverage)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/shivam091/composite_unit_measurements/blob/main/LICENSE)

**Harshal V. Ladhe, M.Sc. Computer Science.**

## Introduction

The `CompositeUnitMeasurements` gem offers versatile parsers for efficiently parsing
composite measurement strings. Leveraging the power of the `unit_measurements` gem,
it enables smooth handling of composite measurements in various units.

## Minimum Requirements

* Ruby 3.2.2+ ([Download Ruby](https://www.ruby-lang.org/en/downloads/branches/))

## Installation

To use `composite_unit_measurements-rails` in your Rails application, add the
following line to your Gemfile:

```ruby
gem "composite_unit_measurements"
```

And then execute:

`$ bundle install`

Or otherwise simply install it yourself as:

`$ gem install composite_unit_measurements`

## Usage

Each packaged parser includes the `#parse` method to parse composite measurements.
You can use an appropriate parser to parse measurements. The final result of `#parse`
is returned in the leftmost unit of your measurement.

This gem internally uses [`unit_measurements`](https://github.com/shivam091/unit_measurements)
to perform conversions and arithmetic operations. You can build supported composite measurements
using any [unit alias](https://github.com/shivam091/unit_measurements/blob/main/units.md).

### Examples

**Parsing length measurements:**

```ruby
CompositeUnitMeasurements::Length.parse("5 ft 6 in")
#=> 5.5 ft
CompositeUnitMeasurements::Length.parse("6 m 50 cm")
#=> 6.5 m
CompositeUnitMeasurements::Length.parse("5 km 500 m")
#=> 5.5 km
```

**Parsing weight measurements:**

```ruby
CompositeUnitMeasurements::Weight.parse("8 lb 12 oz")
#=> 8.75 lb
CompositeUnitMeasurements::Weight.parse("2 st 6 lb")
#=> 2.428571428571429 st
CompositeUnitMeasurements::Weight.parse("2 st 6 lb")
# 4.5 kg
```

**Parsing time measurements:**

```ruby
CompositeUnitMeasurements::Time.parse("3 h 45 min")
#=> 3.75 hx
CompositeUnitMeasurements::Time.parse("12:60:3600,360000000")
#=> 14.1 h
```

### Support for numeric types

Each parser can handle various numeric types, including scientific notation, rational numbers, and complex numbers.

```ruby
CompositeUnitMeasurements::Length.parse("1+2i ft 12 in")
#=> 2.0+2.0i ft
CompositeUnitMeasurements::Length.parse("1.5 ft 12e2 in")
#=> 101.5 ft
CompositeUnitMeasurements::Length.parse("1 1/2 ft 1+2i in")
#=> 1.5833333333333333+0.16666666666666669i ft
CompositeUnitMeasurements::Length.parse("2 ft 1+2i in")
#=> 2.0833333333333335+0.16666666666666669i ft
CompositeUnitMeasurements::Length.parse("1e-2 ft 1+2i in")
#=> 0.09333333333333334+0.16666666666666669i ft
```

## Packaged parsers & supported composite measurements

The `composite_unit_measurements` gem supports parsing various composite measurements, including:

**1. CompositeUnitMeasurements::Length**
- foot-inch (5 ft 6 in)
- metre-centimetre (6 m 50 cm)
- kilometre-metre (5 km 500 m)

**2. CompositeUnitMeasurements::Weight**
- pound-ounce (8 lb 12 oz)
- stone-pound (2 st 6 lb)
- kilogramme-gramme (4 kg 500 g)

**3. CompositeUnitMeasurements::Time**
- hour-minute (3 h 45 min)
- hour-minute-second-microsecond (12:60,3600:360000000)

### Specifing parsers

By default, `composite_unit_measurements` includes all packaged parsers automatically
when required in your application. However, you can opt to use specific parsers as
needed:

```ruby
require "composite_unit_measurements/base"

require "composite_unit_measurements/length"
require "composite_unit_measurements/weight"
```

## Contributing

Contributions to this project are welcomed! To contribute:

1. Fork this repository
2. Create a new branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Add some feature"`)
4. Push the changes to your branch (`git push origin my-new-feature`)
5. Create new **Pull Request**

## License

Copyright 2023 [Harshal V. LADHE]((https://shivam091.github.io)), Released under the [MIT License](http://opensource.org/licenses/MIT).
