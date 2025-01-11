# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

require "unit_measurements/unit_groups/weight"

module CompositeUnitMeasurements
  # A parser handling +weight+ measurements, particularly for composite units
  # like +kilogramme-gramme+, +pound-ounce+, +stone-pound+ etc.
  #
  # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
  # @since 0.2.0
  class Weight
    class << self
      # Parses a given +string+ into a +UnitMeasurements::Weight+ object.
      #
      # @example Parse 'pound-ounce' measurement:
      #   CompositeUnitMeasurements::Weight.parse("8 lb 12 oz") #=> 8.75 lb
      # @example Parse 'stone-pound' measurement:
      #   CompositeUnitMeasurements::Weight.parse("2 st 6 lb") #=> 2.428571428571429 st
      # @example Parse 'kilogramme-gramme' measurement:
      #   CompositeUnitMeasurements::Weight.parse("4 kg 500 g") #=> 4.5 kg
      # @example Parse 'tonne-kilogramme' measurement:
      #   CompositeUnitMeasurements::Weight.parse("1 t 500 kg") #=> 1.5 t
      #
      # @param [String] string The string to parse for weight measurement.
      # @return [UnitMeasurements::Weight]
      #   Returns a UnitMeasurements::Weight object if parsing is successful.
      # @raise [UnitMeasurements::ParseError]
      #   If the string does not match any known format.
      #
      # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
      # @since 0.2.0
      def parse(string)
        case string
        when POUND_OUNCE       then parse_pound_ounce(string)
        when STONE_POUND       then parse_stone_pound(string)
        when KILOGRAMME_GRAMME then parse_kilogramme_gramme(string)
        when TONNE_KILOGRAMME  then parse_tonne_kilogramme(string)
        else                        raise UnitMeasurements::ParseError, string
        end
      end

      private

      # @private
      # Parses a +string+ representing a weight in the format of +pound-ounce+
      # into a +UnitMeasurements::Weight+ object.
      #
      # @param [String] string
      #   The string representing weight measurement in the format of *pound-ounce*.
      # @return [UnitMeasurements::Weight]
      #   Returns a UnitMeasurements::Weight object if parsing is successful.
      #
      # @see POUND_OUNCE
      # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
      # @since 0.2.0
      def parse_pound_ounce(string)
        pound, ounce = string.match(POUND_OUNCE)&.captures

        if pound && ounce
          UnitMeasurements::Weight.new(pound, "lb") + UnitMeasurements::Weight.new(ounce, "oz")
        end
      end

      # @private
      # Parses a +string+ representing a weight in the format of +stone-pound+
      # into a +UnitMeasurements::Weight+ object.
      #
      # @param [String] string
      #   The string representing weight measurement in the format of *stone-pound*.
      # @return [UnitMeasurements::Weight]
      #   Returns a UnitMeasurements::Weight object if parsing is successful.
      #
      # @see STONE_POUND
      # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
      # @since 0.2.0
      def parse_stone_pound(string)
        stone, pound = string.match(STONE_POUND)&.captures

        if stone && pound
          UnitMeasurements::Weight.new(stone, "st") + UnitMeasurements::Weight.new(pound, "lb")
        end
      end

      # @private
      # Parses a +string+ representing a weight in the format of +kilogramme-gramme+
      # into a +UnitMeasurements::Weight+ object.
      #
      # @param [String] string
      #   The string representing weight measurement in the format of *kilogramme-gramme*.
      # @return [UnitMeasurements::Weight]
      #   Returns a UnitMeasurements::Weight object if parsing is successful.
      #
      # @see KILOGRAMME_GRAMME
      # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
      # @since 0.3.0
      def parse_kilogramme_gramme(string)
        kilogramme, gramme = string.match(KILOGRAMME_GRAMME)&.captures

        if kilogramme && gramme
          UnitMeasurements::Weight.new(kilogramme, "kg") + UnitMeasurements::Weight.new(gramme, "g")
        end
      end

      # @private
      # Parses a +string+ representing a weight in the format of +tonne-kilogramme+
      # into a +UnitMeasurements::Weight+ object.
      #
      # @param [String] string
      #   The string representing weight measurement in the format of *tonne-kilogramme*.
      # @return [UnitMeasurements::Weight]
      #   Returns a UnitMeasurements::Weight object if parsing is successful.
      #
      # @see TONNE_KILOGRAMME
      # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
      # @since 0.6.0
      def parse_tonne_kilogramme(string)
        tonne, kilogramme = string.match(TONNE_KILOGRAMME)&.captures

        if tonne && kilogramme
          UnitMeasurements::Weight.new(tonne, "t") + UnitMeasurements::Weight.new(kilogramme, "kg")
        end
      end
    end

    # Regex pattern for aliases of +pound+ unit.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.2.0
    POUND_ALIASES = /(?:#|lb|lbs|lbm|pound-mass|pound(?:s)?)/.freeze

    # Regex pattern for aliases of +ounce+ unit.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.2.0
    OUNCE_ALIASES = /(?:oz|ounce(?:s)?)/.freeze

    # Regex pattern for aliases of +stone+ unit.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.2.0
    STONE_ALIASES = /(?:st|stone(?:s)?)/.freeze

    # Regex pattern for aliases of +gramme+ unit.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.3.0
    GRAMME_ALIASES = /(?:g|gram(?:s)?|gramme(?:s)?)/.freeze

    # Regex pattern for aliases of +kilogramme+ unit.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.3.0
    KILOGRAMME_ALIASES = /(?:kg|kilogram(?:s)?|kilogramme(?:s)?)/.freeze

    # Regex pattern for aliases of +tonne+ or +metric tonne+ unit.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.6.0
    TONNE_ALIASES = /(?:t|tonne(?:s)?|metric tonne(?:s)?)/.freeze

    # Regex pattern for parsing a weight measurement in the format of +pound-ounce+.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.2.0
    POUND_OUNCE = /\A#{ANY_NUMBER}\s*#{POUND_ALIASES}\s*#{ANY_NUMBER}\s*#{OUNCE_ALIASES}\z/.freeze

    # Regex pattern for parsing a weight measurement in the format of +stone-pound+.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.2.0
    STONE_POUND = /\A#{ANY_NUMBER}\s*#{STONE_ALIASES}\s*#{ANY_NUMBER}\s*#{POUND_ALIASES}\z/.freeze

    # Regex pattern for parsing a weight measurement in the format of +kilogramme-gramme+.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.3.0
    KILOGRAMME_GRAMME = /\A#{ANY_NUMBER}\s*#{KILOGRAMME_ALIASES}\s*#{ANY_NUMBER}\s*#{GRAMME_ALIASES}\z/.freeze

    # Regex pattern for parsing a weight measurement in the format of +tonne-kilogramme+.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.6.0
    TONNE_KILOGRAMME  = /\A#{ANY_NUMBER}\s*#{TONNE_ALIASES}\s*#{ANY_NUMBER}\s*#{KILOGRAMME_ALIASES}\z/.freeze

    private_constant :POUND_ALIASES, :OUNCE_ALIASES, :STONE_ALIASES, :GRAMME_ALIASES,
                     :KILOGRAMME_ALIASES, :TONNE_ALIASES, :POUND_OUNCE, :STONE_POUND,
                     :KILOGRAMME_GRAMME, :TONNE_KILOGRAMME
  end
end
