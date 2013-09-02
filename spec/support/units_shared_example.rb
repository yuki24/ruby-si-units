# coding: utf-8
require 'spec_helper'

shared_examples "is unit of" do |unit, expected_prefix|

  it "is max limit on range" do
    expect(:unit.to_s).to eql(expected_prefix)
  end

  it "is min limit on range" do
    expect(:unit.to_s).to eql(expected_prefix)
  end

  it "out of unit range" do
    expect(:unit.to_s).to_not eql(expected_prefix)
  end
end
