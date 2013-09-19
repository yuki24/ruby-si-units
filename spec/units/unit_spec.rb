# coding: utf-8
require 'spec_helper'
require "unit"

describe SIUnits::Unit do

  context "it's a pico " do
    it "max limit" do
      unit = SIUnits::Unit.new((1e-15) + 0.0000000000001)
      expect(unit.best_scale).to match(/[p]/)
    end

    it "min limit" do
      unit = SIUnits::Unit.new(1e-12)
      expect(unit.best_scale).to match(/[p]/)
    end

    it "not a pico" do
      unit = SIUnits::Unit.new((1e-12) + 0.0000000000001)
      expect(unit.best_scale).to_not match(/[p]/)
    end
  end

  context "it's a nano " do
    it "max limit" do
      unit = SIUnits::Unit.new((1e-12) + 0.00000000001)
      expect(unit.best_scale).to match(/[n]/)
    end

    it "min limit" do
      unit = SIUnits::Unit.new(1e-9)
      expect(unit.best_scale).to match(/[n]/)
    end

    it "not a nano" do
      unit = SIUnits::Unit.new((1e-9) + 0.00000000001)
      expect(unit.best_scale).to_not match(/[n]/)
    end
  end

  context "it's a micro " do
    it "max limit" do
      unit = SIUnits::Unit.new((1e-9) + 0.00000000001)
      expect(unit.best_scale).to match(/[u]/)
    end

    it "min limit" do
      unit = SIUnits::Unit.new(1e-6)
      expect(unit.best_scale).to match(/[u]/)
    end

    it "not a micro" do
      unit = SIUnits::Unit.new((1e-6) + 0.000001)
      expect(unit.best_scale).to_not match(/[u]/)
    end
  end

  context "it's a milli " do
    it "max limit" do
      unit = SIUnits::Unit.new((1e-6) + 0.000001)
      expect(unit.best_scale).to match(/[m]/)
    end

    it "min limit" do
      unit = SIUnits::Unit.new(1e-3)
      expect(unit.best_scale).to match(/[m]/)
    end

    it "not a milli" do
      unit = SIUnits::Unit.new((1e-3) + 0.001)
      expect(unit.best_scale).to_not match(/[m]/)
    end
  end

  context "it's a centi " do
    it "max limit" do
      unit = SIUnits::Unit.new((1e-3) + 0.001)
      expect(unit.best_scale).to match(/[c]/)
    end

    it "min limit" do
      unit = SIUnits::Unit.new(1e-2)
      expect(unit.best_scale).to match(/[c]/)
    end

    it "not a centi" do
      unit = SIUnits::Unit.new((1e-2) + 0.001)
      expect(unit.best_scale).to_not match(/[c]/)
    end
  end

  context "it's a deci " do
    it "max limit" do
      unit = SIUnits::Unit.new((1e-2) + 0.01)
      expect(unit.best_scale).to match(/[d]/)
    end

    it "min limit" do
      unit = SIUnits::Unit.new(1e-1)
      expect(unit.best_scale).to match(/[d]/)
    end

    it "not a deci" do
      unit = SIUnits::Unit.new((1e-1) + 0.01)
      expect(unit.best_scale).to_not match(/[d]/)
    end
  end

  context "it's a const " do

    it "zero" do
      unit = SIUnits::Unit.new(0)
      expect(unit.best_scale).to match(/zero/)
    end

    it "not a zero" do
      unit = SIUnits::Unit.new(0.1)
      expect(unit.best_scale).to_not match(/zero/)
    end
  end

  context "it's a deca " do
    it "max limit" do
      unit = SIUnits::Unit.new((1e2) - 1.0)
      expect(unit.best_scale).to match(/(da)/)
    end

    it "min limit" do
      unit = SIUnits::Unit.new(1e1 + 1.0)
      expect(unit.best_scale).to match(/(da)/)
    end

    it "not a deca" do
      unit = SIUnits::Unit.new((1e1) - 1.0)
      expect(unit.best_scale).to_not match(/da/)
    end
  end

  context "it's a hecto " do
    it "max limit" do
      unit = SIUnits::Unit.new((1e3) - 1.0)
      expect(unit.best_scale).to match(/[h]/)
    end

    it "min limit" do
      unit = SIUnits::Unit.new(1e2 + 1.0)
      expect(unit.best_scale).to match(/[h]/)
    end

    it "not a deca" do
      unit = SIUnits::Unit.new((1e2) - 1.0)
      expect(unit.best_scale).to_not match(/[h]/)
    end
  end

  context "it's a kilo " do
    it "max limit" do
      unit = SIUnits::Unit.new((1e6) - 1.0)
      expect(unit.best_scale).to match(/[k]/)
    end

    it "min limit" do
      unit = SIUnits::Unit.new(1e3 + 1.0)
      expect(unit.best_scale).to match(/[k]/)
    end

    it "not a deca" do
      unit = SIUnits::Unit.new((1e3) - 1.0)
      expect(unit.best_scale).to_not match(/[k]/)
    end
  end

  context "it's a mega " do
    it "max limit" do
      unit = SIUnits::Unit.new((1e9) - 1.0)
      expect(unit.best_scale).to match(/[M]/)
    end

    it "min limit" do
      unit = SIUnits::Unit.new(1e6 + 1.0)
      expect(unit.best_scale).to match(/[M]/)
    end

    it "not a deca" do
      unit = SIUnits::Unit.new((1e6) - 1.0)
      expect(unit.best_scale).to_not match(/[M]/)
    end
  end

  context "it's a giga " do
    it "max limit" do
      unit = SIUnits::Unit.new((1e12) - 1.0)
      expect(unit.best_scale).to match(/[G]/)
    end

    it "min limit" do
      unit = SIUnits::Unit.new(1e9 + 1.0)
      expect(unit.best_scale).to match(/[G]/)
    end

    it "not a deca" do
      unit = SIUnits::Unit.new((1e9) - 1.0)
      expect(unit.best_scale).to_not match(/[G]/)
    end
  end

  context "Its comparable" do
    it "Compare with"
  end

  context "Convert to" do
    it "Convert to"
  end

end
