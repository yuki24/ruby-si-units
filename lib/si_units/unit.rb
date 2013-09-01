module SIUnits
  class Unit
    include Comparable
    attr_reader :unit_value

    #SI Prefix Units
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
      '1'      => [%w{const},                 1],
      'deci'   => [%w{d Deci deci},       1e-1],
      'centi'  => [%w{c Centi centi},     1e-2],
      'milli'  => [%w{m Milli milli},     1e-3],
      'micro'  => [%w{u Micro micro},     1e-6],
      'nano'   => [%w{n Nano nano},       1e-9],
      'pico'   => [%w{p Pico pico},       1e-12],
      'femto'  => [%w{f Femto femto},     1e-15],
      'atto'   => [%w{a Atto atto},       1e-18],
      'zepto'  => [%w{z Zepto zepto},     1e-21],
      'yocto'  => [%w{y Yocto yocto},     1e-24]
    }

    def initialize(unit)
      @unit_value = unit
      @unit_kind = parse_unit
    end

    def parse
      @unit_with_best_scale ||= best_scale
    end

    # def <=>(comparison)
    #   UNITS_DEFINITION.find_index(@unit_kind) <=> UNITS_DEFINITION.find_index(comparison.unit_kind)
    # end

    private

    def best_scale
      aliase, scalar = UNITS_DEFINITION[@unit_kind]
      [@unit_value / scalar, aliase.first ].join
    end

    def parse_unit
      case @unit_value
      when 1e-15..1e-12 then return "pico"
      when 1e-12..1e-9 then return "nano"
      when 1e-9..1e-6 then return "micro"
      when 1e-6..1e-3 then return "milli"
      when 1e-3..1e-2 then return "centi"
      when 1e-2..1e-1 then return "deci"
      when 1e-1..0e1 then return "1"
      when 0e1..1e1 then return "1"
      when 1e1..1e2 then return "deca"
      when 1e2..1e3 then return "hecto"
      when 1e3..1e6 then return "kilo"
      when 1e6..1e9 then return "mega"
      when 1e9..1e12 then return "giga"
      else raise "Unit out of range"
      end
    end

  end
end
