# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

# spec/composite_unit_measurements/length_spec.rb

RSpec.describe CompositeUnitMeasurements::Length do
  subject(:length) { described_class }

  describe "#parse" do
    context "when valid string is passed" do
      it "parses foot and inch" do
        expect(length.parse("5 \' 6 \"").to_s).to eq("5.5 ft")
        expect(length.parse("5 ft 6 in").to_s).to eq("5.5 ft")
        expect(length.parse("5 foot 6 inch").to_s).to eq("5.5 ft")
        expect(length.parse("5 feet 6 inches").to_s).to eq("5.5 ft")
      end
    end

    context "when invalid string is passed" do
      it "raises an error" do
        expect { length.parse("5 feets 6 inches") }.to raise_error(UnitMeasurements::ParseError)
        expect { length.parse("5 feets 6 inche").to_s }.to raise_error(UnitMeasurements::ParseError)
        expect { length.parse("5 foots 6 inched").to_s }.to raise_error(UnitMeasurements::ParseError)
        expect { length.parse("5 fts 6 ines").to_s }.to raise_error(UnitMeasurements::ParseError)
      end
    end
  end
end
