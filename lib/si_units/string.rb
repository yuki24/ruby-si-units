class String
  # make a string into a unit
  # @return (see RubyUnits::Unit#initialize)
  def to_unit
    unit_reduced, prefix = *split_value(self)
    SIUnits::Unit.new(unit_reduced).convert_to(prefix)
  end

  def split_value(value)
    value.scan(/(\d+\.?\d*)(\w+)/).flatten
  end
end

