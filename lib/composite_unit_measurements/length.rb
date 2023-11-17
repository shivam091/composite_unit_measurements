# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

require "unit_measurements/unit_groups/length"

module CompositeUnitMeasurements
  # A parser handling +length+ measurements, particularly for composite units
  # like +foot-inch+, +kilometre-metre+, +mile-yard+, etc.
  #
  # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
  # @since 0.2.0
  class Length
    class << self
      # Parses a given +string+ into a +UnitMeasurements::Length+ object.
      #
      # @param [String] string The string to parse for length measurement.
      # @return [UnitMeasurements::Length]
      #   Returns a UnitMeasurements::Length object if parsing is successful.
      # @raise [UnitMeasurements::ParseError]
      #   If the string does not match any known format.
      #
      # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
      # @since 0.2.0
      def parse(string)
        case string
        when FOOT_INCH then parse_foot_inch(string)
        else                raise UnitMeasurements::ParseError, string
        end
      end

      private

      # @private
      # Parses a +string+ representing a length in the format of +foot-inch+.
      #
      # @param [String] string
      #   The string representing length measurement in the format of *foot-inch*.
      # @return [UnitMeasurements::Length]
      #   Returns a UnitMeasurements::Length object if parsing is successful.
      #
      # @see FOOT_INCH
      # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
      # @since 0.2.0
      def parse_foot_inch(string)
        foot, inch = string.match(FOOT_INCH)&.captures

        if foot && inch
          UnitMeasurements::Length.new(foot, :ft) + UnitMeasurements::Length.new(inch, :in)
        end
      end
    end

    private

    # Regex pattern for aliases of +foot+ unit.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.2.0
    FOOT_ALIASES = /(?:'|ft|foot|feet)/.freeze

    # Regex pattern for aliases of +inch+ unit.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.2.0
    INCH_ALIASES = /(?:"|in|inch(?:es)?)/.freeze

    # Regex pattern for parsing a length measurement in the format of +foot-inch+.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.2.0
    FOOT_INCH = /\A#{ANY_NUMBER}\s*#{FOOT_ALIASES}\s*#{ANY_NUMBER}\s*#{INCH_ALIASES}\z/.freeze
  end
end
