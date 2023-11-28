# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

# spec/composite_unit_measurements/volume_spec.rb

RSpec.describe CompositeUnitMeasurements::Volume do
  describe ".parse" do
    context "when valid string is passed" do
      it "parses litre and millilitre" do
        expect(described_class.parse("2 l 250 ml").to_s).to eq("2.25 l")
        expect(described_class.parse("2 L 250 mL").to_s).to eq("2.25 l")
        expect(described_class.parse("2 liter 250 milliliter").to_s).to eq("2.25 l")
        expect(described_class.parse("2 liters 250 milliliters").to_s).to eq("2.25 l")
        expect(described_class.parse("2 litre 250 millilitre").to_s).to eq("2.25 l")
        expect(described_class.parse("2 litres 250 millilitres").to_s).to eq("2.25 l")
      end
    end

    context "when invalid string is passed" do
      it "raises an error" do
        expect { described_class.parse("2 literss 250 milliliterss") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("2 literss 250 milliliterr") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("2 litress 250 millilitress").to_s }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("2 ls 250 mls").to_s }.to raise_error(UnitMeasurements::ParseError)
      end
    end
  end
end
