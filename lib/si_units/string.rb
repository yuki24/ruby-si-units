class String
  # make a string into a unit
  # @return (see RubyUnits::Unit#initialize)
  def to_unit
    SIUnits::Unit.new(self)
  end
end

