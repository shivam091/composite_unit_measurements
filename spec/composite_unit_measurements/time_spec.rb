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

      it "parses minute and second" do
        expect(described_class.parse("10 min 90 s").to_s).to eq("11.5 min")
        expect(described_class.parse("10 min 90 sec").to_s).to eq("11.5 min")
        expect(described_class.parse("10 minute 90 second").to_s).to eq("11.5 min")
        expect(described_class.parse("10 minutes 90 seconds").to_s).to eq("11.5 min")
      end

      it "parses week and day" do
        expect(described_class.parse("8 wk 3 d").to_s).to eq("8.428571428571429 wk")
        expect(described_class.parse("8 week 3 day").to_s).to eq("8.428571428571429 wk")
        expect(described_class.parse("8 weeks 3 days").to_s).to eq("8.428571428571429 wk")
      end

      it "parses month and day" do
        expect(described_class.parse("2 mo 60 d").to_s).to eq("3.97260057797197 mo")
        expect(described_class.parse("2 month 60 day").to_s).to eq("3.97260057797197 mo")
        expect(described_class.parse("2 months 60 days").to_s).to eq("3.97260057797197 mo")
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

        expect { described_class.parse("10 mins 90 s") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("10 minutess 90 secs") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("10 minutez 90 secondz") }.to raise_error(UnitMeasurements::ParseError)

        expect { described_class.parse("8 wks 3 ds") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("8 weekss 3 dayss") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("8 weekz 3 dayz") }.to raise_error(UnitMeasurements::ParseError)

        expect { described_class.parse("2 mos 60 ds") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("2 monthss 60 dayss") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("2 monthz 60 dayz") }.to raise_error(UnitMeasurements::ParseError)
      end
    end
  end
end
