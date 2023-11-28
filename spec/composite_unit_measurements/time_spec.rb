# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

# spec/composite_unit_measurements/time_spec.rb

RSpec.describe CompositeUnitMeasurements::Time do
  describe ".parse" do
    context "when valid string is passed" do
      it "parses hour and minute" do
        expect(described_class.parse("3 h 45 min").to_s).to eq("3.75 h")
        expect(described_class.parse("3 hr 45 min").to_s).to eq("3.75 h")
        expect(described_class.parse("3 hour 45 minute").to_s).to eq("3.75 h")
        expect(described_class.parse("3 hours 45 minutes").to_s).to eq("3.75 h")
      end

      it "parses duration" do
        expect(described_class.parse("12:60:3600,360000000").to_s).to eq("14.1 h")
        expect(described_class.parse("12:60:3600").to_s).to eq("14.0 h")
      end
    end

    context "when invalid string is passed" do
      it "raises an error" do
        expect { described_class.parse("3 hs 45 mins") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("3 hourz 45 minutez") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("3 hou 45 minut") }.to raise_error(UnitMeasurements::ParseError)

        expect { described_class.parse("12:60") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("12:60,3600:360000000").to_s }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("12:60,3600,360000000").to_s }.to raise_error(UnitMeasurements::ParseError)
      end
    end
  end
end
