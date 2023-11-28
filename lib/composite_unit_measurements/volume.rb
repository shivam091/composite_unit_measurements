# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

require "unit_measurements/unit_groups/volume"

module CompositeUnitMeasurements
  # A parser handling +volume+ measurements, particularly for composite units
  # like +litre-millilitre+, +gallon-quart+, +quart-pint+, etc.
  #
  # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
  # @since 0.4.0
  class Volume
    class << self
      # Parses a given +string+ into a +UnitMeasurements::Volume+ object.
      #
      # @example Parse 'litre-millilitre' measurement:
      #   CompositeUnitMeasurements::Volume.parse("2 l 250 ml") #=> 2.25 l
      #
      # @param [String] string The string to parse for volume measurement.
      # @return [UnitMeasurements::Volume]
      #   Returns a UnitMeasurements::Volume object if parsing is successful.
      #
      # @raise [UnitMeasurements::ParseError]
      #   If the string does not match any known format.
      #
      # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
      # @since 0.4.0
      def parse(string)
        case string
        when LITRE_MILLILITRE then parse_litre_millilitre(string)
        else                       raise UnitMeasurements::ParseError, string
        end
      end

      private

      # @private
      # Parses a +string+ representing a volume in the format of +litre-millilitre+
      # into a +UnitMeasurements::Volume+ object.
      #
      # @param [String] string
      #   The string representing volume measurement in the format of *litre-millilitre*.
      # @return [UnitMeasurements::Volume]
      #   Returns a UnitMeasurements::Volume object if parsing is successful.
      #
      # @see LITRE_MILLILITRE
      # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
      # @since 0.4.0
      def parse_litre_millilitre(string)
        litre, millilitre = string.match(LITRE_MILLILITRE)&.captures

        if litre && millilitre
          UnitMeasurements::Volume.new(litre, "l") + UnitMeasurements::Volume.new(millilitre, "ml")
        end
      end
    end

    # Regex pattern for aliases of +litre+ unit.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.4.0
    LITRE_ALIASES = /(?:l|L|liter(?:s)?|litre(?:s)?)/.freeze

    # Regex pattern for aliases of +millilitre+ unit.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.4.0
    MILLILITRE_ALIASES = /(?:ml|mL|milliliter(?:s)?|millilitre(?:s)?)/.freeze

    # Regex pattern for parsing a volume measurement in the format of +litre-millilitre+.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.4.0
    LITRE_MILLILITRE = /\A#{ANY_NUMBER}\s*#{LITRE_ALIASES}\s*#{ANY_NUMBER}\s*#{MILLILITRE_ALIASES}\z/.freeze

    private_constant :LITRE_MILLILITRE, :LITRE_ALIASES, :MILLILITRE_ALIASES
  end
end
