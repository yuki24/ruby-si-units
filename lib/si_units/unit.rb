#coding: utf-8
# = SIUnits
# A SI prefix unit handling library for ruby
#
# @author Kenner Kliemann
# @see https://github.com/gnomex/ruby-si-units
module SIUnits
  class Unit
    include Comparable

    attr_reader :value, :kind

    # Definition of SI Prefix Units, with name, aliases and scale
    UNITS_DEFINITION = {
      'googol' => [%w{googol},            1e100],
      'yebi'   => [%w{Yi Yebi yebi},      2**80],
      'zebi'   => [%w{Zi Zebi zebi},      2**70],
      'exi'    => [%w{Ei Exi exi},        2**60],
      'pebi'   => [%w{Pi Pebi pebi},      2**50],
      'tebi'   => [%w{Ti Tebi tebi},      2**40],
      'gibi'   => [%w{Gi Gibi gibi},      2**30],
      'mebi'   => [%w{Mi Mebi mebi},      2**20],
      'kibi'   => [%w{Ki Kibi kibi},      2**10],
      'yotta'  => [%w{Y Yotta yotta},     1e24],
      'zetta'  => [%w{Z Zetta zetta},     1e21],
      'exa'    => [%w{E Exa exa},         1e18],
      'peta'   => [%w{P Peta peta},       1e15],
      'tera'   => [%w{T Tera tera},       1e12],
      'giga'   => [%w{G Giga giga},       1e9],
      'mega'   => [%w{M Mega mega},       1e6],
      'kilo'   => [%w{k kilo},            1e3],
      'hecto'  => [%w{h Hecto hecto},     1e2],
      'deca'   => [%w{da Deca deca deka}, 1e1],
      '1'      => [%w{const},                1],
      'deci'   => [%w{d Deci deci},       1e-1],
      'centi'  => [%w{c Centi centi},     1e-2],
      'milli'  => [%w{m Milli milli},     1e-3],
      'micro'  => [%w{u Micro micro},     1e-6],
      'nano'   => [%w{n Nano nano},       1e-9],
      'pico'   => [%w{p Pico pico},       1e-12],
      'femto'  => [%w{f Femto femto},     1e-15],
      'atto'   => [%w{a Atto atto},       1e-18],
      'zepto'  => [%w{z Zepto zepto},     1e-21],
      'yocto'  => [%w{y Yocto yocto},     1e-24],
      'zero'   => [%w{zero},                0.0]
    }
    UNIT_REGEX = /(^(?:[1-9]\d*|0)(?:\.\d+)?)(\s*\w)$/

    # Create a new Unit object.
    # => Initialize with a numeric or string
    # @raise [ArgumentError] if no unit is specified
    # @raise [ArgumentError] if an invalid unit is specified
    def initialize(options)
      raise ArgumentError, "Unit can't be initialized without args" if options.nil?

      case options
      when Numeric
        @value = options.to_f # Force evaluation to float!
        @kind = parse_unit

      when String
        value, prefix = split_value(options.split.join)

        @kind = who_is_my_prefix?(prefix)
        # Value is absolute, needs convert to scale of prefix
        @value = value.to_f * scale
      else
        raise ArgumentError, "Invalid Unit Format"
      end
    end

    # Public call to get a unit best representation
    # @return String
    def best_scale
       @best_scale ||= best_value_with_scale
    end

    # Comparable units
    # => Compare with scale of kinds
    def <=>(comparison)
      UNITS_DEFINITION[kind].last <=> UNITS_DEFINITION[comparison.kind].last
    end

    def ==(comparison)
      kind == comparison.kind
    end

    # convert to a specified unit string or to the same unit as another Unit
    def convert_to(other)
      return self if other.nil?

      case other
        when Unit
          return self if other == self
          target = other
        when String
          target = SIUnits::Unit.new(other.to_f)
        else
          raise ArgumentError, "Unknown target units"
      end
    end

    alias :>> :convert_to

    def to_s
      [best_scale, kind].join(' ')
    end

    private

    # Logic to convert the current unit value to a best form of representation
    # == Just remove the "e base" from value
    def best_value_with_scale
      (value / scale).round(4)
    end

    # The parser
    # => Finds that the number range is contained
    # @return String with the name of representation
    # @raise ArgumentError
    def parse_unit
      case @value
      when 0 then "zero"
      when 1e-24..1e-21 then "yocto"
      when 1e-21..1e-18 then "atto"
      when 1e-18..1e-15 then "femto"
      when 1e-15..1e-12 then "pico"
      when 1e-12..1e-9 then "nano"
      when 1e-9..1e-6 then "micro"
      when 1e-6..1e-3 then "milli"
      when 1e-3..1e-2 then "centi"
      when 1e-2..1e-1 then "deci"
      when 1e-1..1e1 then "1"
      when 1e1..1e2 then "deca"
      when 1e2..1e3 then "hecto"
      when 1e3..1e6 then "kilo"
      when 1e6..1e9 then "mega"
      when 1e9..1e12 then "giga"
      when 1e12..1e15 then "tera"
      when 1e15..1e18 then "peta"
      when 1e18..1e21 then "exa"
      when 1e21..1e24 then "zetta"
      else
        raise ArgumentError, "Unit out of range"
      end
    end

    def who_is_my_prefix?(prefix)
      prefix unless UNITS_DEFINITION.has_key?(prefix)

      UNITS_DEFINITION.each do |key, value|
        return key if value[0].include?(prefix)
      end

      raise ArgumentError, "Unknown prefix"
    end

    def scale
      @scale ||= UNITS_DEFINITION[kind].last
    end

    def split_value(value)
      value.scan(UNIT_REGEX).flatten
    end
  end
end
