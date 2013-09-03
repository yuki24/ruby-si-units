#SI Prefix Units
	A SI prefix unit handling library for ruby

[![Build Status](https://travis-ci.org/gnomex/ruby-si-units.png?branch=master)](https://travis-ci.org/gnomex/ruby-si-units)

How it work's ?
===
<p>
  Makes a parce of an absolute value and identifies the scale of the unit that belongs SI, returning the unit in better representation along with the unit symbol prefixed
</p>

## Installation

Add in your application's Gemfile:

    gem "ruby-si-units", "~> 0.0.3"

And using blunder, execute:

    $ bundle install

Or install it yourself:

    $ gem install ruby-si-units


## Usage

### Convert absolute value to a unit with prefix SI notation

```ruby
unit = SIUnits::Unit.new(10000000)
# => #<SIUnits::Unit:0x0000000283b8a8 @unit_value=10000000, @unit_kind="mega">
unit.best_scale
# => "10.0M"
```

```ruby
unit = SIUnits::Unit.new(0.000000001)
# => #<SIUnits::Unit:0x0000000272bb20 @unit_value=1.0e-09, @unit_kind="nano">
unit.best_scale
# => "1.0n"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


Another useful resources
===
* [ruby-units](https://github.com/olbrich/ruby-units)
