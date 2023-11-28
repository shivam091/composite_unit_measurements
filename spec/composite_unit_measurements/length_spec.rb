# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

# spec/composite_unit_measurements/length_spec.rb

RSpec.describe CompositeUnitMeasurements::Length do
  describe ".parse" do
    context "when valid string is passed" do
      it "parses foot and inch" do
        expect(described_class.parse("5 \' 6 \"").to_s).to eq("5.5 ft")
        expect(described_class.parse("5 ft 6 in").to_s).to eq("5.5 ft")
        expect(described_class.parse("5 foot 6 inch").to_s).to eq("5.5 ft")
        expect(described_class.parse("5 feet 6 inches").to_s).to eq("5.5 ft")
      end

      it "parses metre and centimetre" do
        expect(described_class.parse("6 m 50 cm").to_s).to eq("6.5 m")
        expect(described_class.parse("6 meter 50 centimeter").to_s).to eq("6.5 m")
        expect(described_class.parse("6 metre 50 centimetre").to_s).to eq("6.5 m")
        expect(described_class.parse("6 meters 50 centimeters").to_s).to eq("6.5 m")
        expect(described_class.parse("6 metres 50 centimetres").to_s).to eq("6.5 m")
      end

      it "parses kilometre and metre" do
        expect(described_class.parse("5 km 500 m").to_s).to eq("5.5 km")
        expect(described_class.parse("5 kilometer 500 meter").to_s).to eq("5.5 km")
        expect(described_class.parse("5 kilometers 500 meters").to_s).to eq("5.5 km")
        expect(described_class.parse("5 kilometre 500 metre").to_s).to eq("5.5 km")
        expect(described_class.parse("5 kilometres 500 metres").to_s).to eq("5.5 km")
      end
    end

    context "when invalid string is passed" do
      it "raises an error" do
        expect { described_class.parse("5 feets 6 inches") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("5 feets 6 inche").to_s }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("5 foots 6 inched").to_s }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("5 fts 6 ines").to_s }.to raise_error(UnitMeasurements::ParseError)

        expect { described_class.parse("6 ms 50 cms") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("6 meterss 50 centimeterss") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("6 metrez 50 centimetrez") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("6 metrez 50 centimetrez") }.to raise_error(UnitMeasurements::ParseError)

        expect { described_class.parse("5 kms 500 ms") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("5 kilometerss 500 meterss") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("5 kilometerz 500 meterz") }.to raise_error(UnitMeasurements::ParseError)
      end
    end
  end
end
