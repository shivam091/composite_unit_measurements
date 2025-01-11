# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

# spec/composite_unit_measurements/weight_spec.rb

RSpec.describe CompositeUnitMeasurements::Weight do
  describe ".parse" do
    context "when valid string is passed" do
      it "parses pound and ounce" do
        expect(described_class.parse("8 lb 12 oz").to_s).to eq("8.75 lb")
        expect(described_class.parse("8 lbs 12 ounce").to_s).to eq("8.75 lb")
        expect(described_class.parse("8 lbm 12 ounce").to_s).to eq("8.75 lb")
        expect(described_class.parse("8 # 12 ounce").to_s).to eq("8.75 lb")
        expect(described_class.parse("8 pound 12 ounce").to_s).to eq("8.75 lb")
        expect(described_class.parse("8 pounds 12 ounces").to_s).to eq("8.75 lb")
        expect(described_class.parse("8 pound-mass 12 oz").to_s).to eq("8.75 lb")
      end

      it "parses stone and pound" do
        expect(described_class.parse("2 st 6 lb").to_s).to eq("2.428571428571429 st")
        expect(described_class.parse("2 st 6 lbs").to_s).to eq("2.428571428571429 st")
        expect(described_class.parse("2 stone 6 lbm").to_s).to eq("2.428571428571429 st")
        expect(described_class.parse("2 stone 6 #").to_s).to eq("2.428571428571429 st")
        expect(described_class.parse("2 stones 6 pound").to_s).to eq("2.428571428571429 st")
        expect(described_class.parse("2 stones 6 pounds").to_s).to eq("2.428571428571429 st")
      end

      it "parses kilogramme and gramme" do
        expect(described_class.parse("4 kg 500 g").to_s).to eq("4.5 kg")
        expect(described_class.parse("4 kilogramme 500 gramme").to_s).to eq("4.5 kg")
        expect(described_class.parse("4 kilogrammes 500 grammes").to_s).to eq("4.5 kg")
        expect(described_class.parse("4 kilogram 500 gram").to_s).to eq("4.5 kg")
        expect(described_class.parse("4 kilograms 500 grams").to_s).to eq("4.5 kg")
      end

      it "parses tonne and kilogramme" do
        expect(described_class.parse("1 t 500 kg").to_s).to eq("1.5 t")
        expect(described_class.parse("1 tonne 500 kilogram").to_s).to eq("1.5 t")
        expect(described_class.parse("1 tonnes 500 kilograms").to_s).to eq("1.5 t")
        expect(described_class.parse("1 metric tonne 500 kilogramme").to_s).to eq("1.5 t")
        expect(described_class.parse("1 metric tonnes 500 kilogrammes").to_s).to eq("1.5 t")
      end
    end

    context "when invalid string is passed" do
      it "raises an error" do
        expect { described_class.parse("8 lb 12 ozz") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("8 lbb 12 ozz") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("8 ## 12 ounces") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("8 lbms 12 oz") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("8 lbms 12 oz") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("8 poundss 12 ouncess") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("8 lbs 12 ounc") }.to raise_error(UnitMeasurements::ParseError)

        expect { described_class.parse("2 sts 6 lbs") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("2 stoness 6 poundss") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("2 st 6 pound mass") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("2 st 6 pound mass") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("2 st 6 ##") }.to raise_error(UnitMeasurements::ParseError)

        expect { described_class.parse("4 kgs 500 gs") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("4 kilogramz 500 gramz") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("4 kilograms 500 gramss") }.to raise_error(UnitMeasurements::ParseError)

        expect { described_class.parse("1 ts 500 kgs") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("1 tonness 500 kilogramss") }.to raise_error(UnitMeasurements::ParseError)
        expect { described_class.parse("1 metric tonness 500 kilogrammess") }.to raise_error(UnitMeasurements::ParseError)
      end
    end
  end
end
