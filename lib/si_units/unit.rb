#coding: utf-8
# = SIUnits
# A SI prefix unit handling library for ruby
#
# @author Kenner Kliemann
# @see https://github.com/gnomex/ruby-si-units
module SIUnits
  class Unit
    include Comparable

    attr_reader :unit_value, :unit_kind

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
    UNIT_REGEX = /(\d+\.?\d*)(\w+)/

    # Create a new Unit object.
    # @return [Unit]
    # @raise [ArgumentError] if absolute value of a temperature is less than absolute zero
    # @raise [ArgumentError] if no unit is specified
    # @raise [ArgumentError] if an invalid unit is specified
    def initialize(*options)

      raise ArgumentError, "Unit can't be initialized without args" if options[0].nil?

      case options[0]
      when Numeric
        @unit_value = options.first
        @unit_kind = parse_unit
      when String
        value, prefix = *split_value(options[0])
        @unit_value = value.to_f
        @unit_kind = who_is_my_prefix?(prefix)
      else
        raise ArgumentError, "Invalid Unit Format"
      end
    end

    # Public call to get a unit best representation
    # @return String
    def best_scale
      # @best_scale ||= best_value_with_scale
    end

    # Comparable units
    # => Compare with scale of kinds
    def <=>(comparison)
      UNITS_DEFINITION[unit_kind].last <=> UNITS_DEFINITION[comparison.unit_kind].last
    end

    def ==(comparison)
      unit_kind == comparison.unit_kind
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
      # Print only the best_scale value, and kind
      "#{"%.2f" % unit_value } #{ unit_kind }"
    end

    private

    # Logic to convert the current unit value to a best form of representation
    #  Nothing happens if unit are in best scale
    # Convert value, where first decimal needs must be > 0, except zero (0)
    # => Like 1000.0 => 1.0e3, 0.01 => 1.0e-2, zero are zero 0 => 0
    def best_value_with_scale
      aliase, scalar = UNITS_DEFINITION[@unit_kind]

      # [(@unit_value * scalar), aliase.first].join
    end

    # Logic to convert a value with scale
    # @return Float
    # all scales are defined with 1e(+|-)1, then just multiply the scalar
    def convert_base_prefix_to_value(value, scalar)
      value * scalar
    end

    # The parser
    # => Finds that the number range is contained
    # @return String with the name of representation
    # @raise ArgumentError
    def parse_unit
      case @unit_value
      when 0 then return "zero"
      when 1e-24..1e-21 then return "yocto"
      when 1e-21..1e-18 then return "atto"
      when 1e-18..1e-15 then return "femto"
      when 1e-15..1e-12 then return "pico"
      when 1e-12..1e-9 then return "nano"
      when 1e-9..1e-6 then return "micro"
      when 1e-6..1e-3 then return "milli"
      when 1e-3..1e-2 then return "centi"
      when 1e-2..1e-1 then return "deci"
      when 1e-1..1e1 then return "1"
      when 1e1..1e2 then return "deca"
      when 1e2..1e3 then return "hecto"
      when 1e3..1e6 then return "kilo"
      when 1e6..1e9 then return "mega"
      when 1e9..1e12 then return "giga"
      when 1e12..1e15 then return "tera"
      when 1e15..1e18 then return "peta"
      when 1e18..1e21 then return "exa"
      when 1e21..1e24 then return "zetta"
      else raise ArgumentError, "Unit out of range"
      end
    end

    def who_is_my_prefix?(prefix)
      UNITS_DEFINITION.each { |key, value|
        return key if value[0].include?(prefix)
      }
      raise ArgumentError, "Unknown prefix"
    end

    def split_value(value)
      value.scan(UNIT_REGEX).flatten
    end
  end
end
