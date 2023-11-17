# Composite Unit Measurements

A set of specialized parsers for dealing with composite measurement strings.

[![Ruby](https://github.com/shivam091/composite_unit_measurements/actions/workflows/main.yml/badge.svg)](https://github.com/shivam091/composite_unit_measurements/actions/workflows/main.yml)
[![Gem Version](https://badge.fury.io/rb/composite_unit_measurements.svg)](https://badge.fury.io/rb/composite_unit_measurements)
[![Gem Downloads](https://img.shields.io/gem/dt/composite_unit_measurements.svg)](http://rubygems.org/gems/composite_unit_measurements)
[![Maintainability](https://api.codeclimate.com/v1/badges/94e13b43cdd19e6c462c/maintainability)](https://codeclimate.com/github/shivam091/composite_unit_measurements/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/94e13b43cdd19e6c462c/test_coverage)](https://codeclimate.com/github/shivam091/composite_unit_measurements/test_coverage)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/shivam091/composite_unit_measurements/blob/main/LICENSE)

**Harshal V. Ladhe, M.Sc. Computer Science.**

## Introduction

The `CompositeUnitMeasurements` gem is a versatile solution tailored for parsing
composite measurement strings. By harnessing the capabilities of the `unit_measurements`
gem, it empowers you to seamlessly handle composite measurements in various units.

## Minimum Requirements

* Ruby 3.2.2+ (https://www.ruby-lang.org/en/downloads/branches/)

## Installation

If using bundler, first add this line to your application's Gemfile:

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
to perform conversions and arithmetic operations. You can use any
[alias of the units](https://github.com/shivam091/unit_measurements/blob/main/units.md)
to build a supported composite measurements.

```ruby
CompositeUnitMeasurements::Length.parse("5 feet 6 inches")
#=> 5.5 ft
CompositeUnitMeasurements::Weight.parse("8 pound 12 ounce")
#=> 8.75 lb
CompositeUnitMeasurements::Time.parse("12:60:60,60")
#=> 13.0166666833333333666667 h
```

Each parser has capability to parse `real`, `rational`, `scientific`, and `complex` numbers.

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

There are tons of composite measurements that are bundled with `composite_unit_measurements`.

**1. UnitMeasurements::CompositeMeasurements::Length**
- foot-inch (5 ft 6 in)

**2. UnitMeasurements::CompositeMeasurements::Weight**
- pound-ounce (8 lb 12 oz)
- stone-pound (2 st 6 lb)

**3. UnitMeasurements::CompositeMeasurements::Time**
- hour-minute-second-microsecond (12:60:60,60)

### Specifing parsers

By default, `composite_unit_measurements` ships with all the packaged parsers and
this happens automatically when you require the gem in the following manner.

```ruby
require "composite_unit_measurements"
```

You can also use parsers in your application as per your need as:

```ruby
require "composite_unit_measurements/base"

require "composite_unit_measurements/length"
require "composite_unit_measurements/weight"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Add some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Copyright 2023 [Harshal V. LADHE]((https://shivam091.github.io)), Released under the [MIT License](http://opensource.org/licenses/MIT).
