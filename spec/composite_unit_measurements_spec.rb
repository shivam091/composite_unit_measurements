# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

# spec/composite_unit_measurements_spec.rb

RSpec.describe CompositeUnitMeasurements do
  let(:length) { CompositeUnitMeasurements::Length }

  it "parses real numbers" do
    expect(length.parse("2 ft 12 in").to_s).to eq("3.0 ft")
    expect(length.parse("-2 ft -12 in").to_s).to eq("-3.0 ft")
  end

  it "parses rational numbers" do
    expect(length.parse("0.5 ft 0.5 in").to_s).to eq("0.5416666666666667 ft")
    expect(length.parse("1/2 ft 1/2 in").to_s).to eq("0.5416666666666667 ft")
    expect(length.parse("1 1/2 ft 1 1/2 in").to_s).to eq("1.625 ft")
    expect(length.parse("-1 1/2 ft -1 1/2 in").to_s).to eq("-0.5416666666666667 ft")
  end

  it "parses scientific numbers" do
    expect(length.parse("1e+1 ft 1e+1 in").to_s).to eq("10.833333333333333 ft")
    expect(length.parse("1e-1 ft 1e-1 in").to_s).to eq("0.10833333333333333 ft")
    expect(length.parse("-1e+1 ft -1e+1 in").to_s).to eq("-10.833333333333333 ft")
    expect(length.parse("-1e-1 ft -1e-1 in").to_s).to eq("-0.10833333333333333 ft")
    expect(length.parse("1e1 ft 1e1 in").to_s).to eq("10.833333333333333 ft")
    expect(length.parse("-1e1 ft -1e1 in").to_s).to eq("-10.833333333333333 ft")
  end

  it "parses complex numbers" do
    expect(length.parse("1+1i ft 1+1i in").to_s).to eq("1.0833333333333333+1.0833333333333333i ft")
    expect(length.parse("1-1i ft 1-1i in").to_s).to eq("1.0833333333333333-1.0833333333333333i ft")
    expect(length.parse("+1-1i ft +1-1i in").to_s).to eq("1.0833333333333333-1.0833333333333333i ft")
    expect(length.parse("-1-1i ft -1-1i in").to_s).to eq("-1.0833333333333333-1.0833333333333333i ft")
    expect(length.parse("1e+2+1i ft 1+1e+2i in").to_s).to eq("100.08333333333333+9.333333333333334i ft")
  end
end
