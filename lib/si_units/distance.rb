module SIUnits

  class Distance
    include Comparable

    UNIT_REGEX = /(\d+)(\w+)/

    attr_reader :value, :unit, :distance

    def initialize(distance)
      @distance = distance
      @value, @unit = *split_value(distance)
    end

    def <=>(comparison)
      u1 = Unit.new(@unit)
      u2 = Unit.new(comparison.unit)

      if u1 > u2
        return 1
      elsif u1 < u2
        return -1
      elsif u1 == u2
        @value.to_i <=> comparison.value.to_i
      end
    end

    private

    def split_value(value)
      value.scan(UNIT_REGEX).flatten
    end

end