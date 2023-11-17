# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

require "unit_measurements/unit_groups/weight"

module CompositeUnitMeasurements
  # A parser handling +weight+ measurements, particularly for composite units
  # like +pound-ounce+, +stone-pound+, +kilogramme-gramme+, etc.
  #
  # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
  # @since 0.2.0
  class Weight
    class << self
      # Parses a given +string+ into a +UnitMeasurements::Weight+ object.
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
        when POUND_OUNCE then parse_pound_ounce(string)
        when STONE_POUND then parse_stone_pound(string)
        else                  raise UnitMeasurements::ParseError, string
        end
      end

      private

      # @private
      # Parses a +string+ representing a weight in the format of +pound-ounce+.
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
          UnitMeasurements::Weight.new(pound, :lb) + UnitMeasurements::Weight.new(ounce, :oz)
        end
      end

      # @private
      # Parses a +string+ representing a weight in the format of +stone-pound+.
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
          UnitMeasurements::Weight.new(stone, :st) + UnitMeasurements::Weight.new(pound, :lb)
        end
      end
    end

    private

    # Regex pattern for aliases of +pound+ unit.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.2.0
    POUND_UNITS = /(?:#|lb|lbs|lbm|pound-mass|pound(?:s)?)/.freeze

    # Regex pattern for aliases of +ounce+ unit.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.2.0
    OUNCE_UNITS = /(?:oz|ounce(?:s)?)/.freeze

    # Regex pattern for aliases of +stone+ unit.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.2.0
    STONE_UNITS = /(?:st|stone(?:s)?)/.freeze

    # Regex pattern for parsing a weight measurement in the format of +pound-ounce+.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.2.0
    POUND_OUNCE = /\A#{ANY_NUMBER}\s*#{POUND_UNITS}\s*#{ANY_NUMBER}\s*#{OUNCE_UNITS}\z/.freeze

    # Regex pattern for parsing a weight measurement in the format of +stone-pound+.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.2.0
    STONE_POUND = /\A#{ANY_NUMBER}\s*#{STONE_UNITS}\s*#{ANY_NUMBER}\s*#{POUND_UNITS}\z/.freeze
  end
end
