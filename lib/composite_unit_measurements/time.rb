# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

require "unit_measurements/unit_groups/time"

module CompositeUnitMeasurements
  # A parser handling +time+ measurements, particularly for composite units
  # like +hour:minute:second,microsecond+, +minute-second+, +hour-minute+, etc.
  #
  # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
  # @since 0.2.0
  class Time
    class << self
      # Parses a given +string+ into a +UnitMeasurements::Time+ object.
      #
      # @param [String] string The string to parse for time measurement.
      # @return [UnitMeasurements::Time]
      #   Returns a UnitMeasurements::Time object if parsing is successful.
      # @raise [UnitMeasurements::ParseError]
      #   If the string does not match any known format.
      #
      # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
      # @since 0.2.0
      def parse(string)
        case string
        when DURATION             then parse_duration(string)
        else                           raise UnitMeasurements::ParseError, string
        end
      end

      private

      # @private
      # Parses a +string+ representing time duration in the format of
      # +hour:minute:second,microsecond+ or +hour:minute:second+.
      #
      # @param [String] string The string representing time duration.
      # @return [UnitMeasurements::Time]
      #   Returns a UnitMeasurements::Time object if parsing is successful.
      # @raise [ArgumentError]
      #   Raises an ArgumentError for an invalid duration format.
      #
      # @see DURATION
      # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
      # @since 0.2.0
      def parse_duration(string)
        hour, minute, second, microsecond = string.match(DURATION)&.captures
        raise ArgumentError, "Invalid Duration" if [hour, minute, second, microsecond].all?(&:nil?)

        UnitMeasurements::Time.new((hour || 0), :h) +
          UnitMeasurements::Time.new((minute || 0), :min) +
          UnitMeasurements::Time.new((second || 0), :s) +
          UnitMeasurements::Time.new((microsecond || 0), :μs)
      end
    end

    private

    # Regex pattern for parsing duration in the format of +hour:minute:second+ or
    # +hour:minute:second,microsecond+.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.2.0
    DURATION = /\A(?<hour>#{REAL_NUMBER}):(?<min>#{REAL_NUMBER}):(?:(?<sec>#{REAL_NUMBER}))?(?:,(?<msec>#{REAL_NUMBER}))?\z/.freeze
  end
end
