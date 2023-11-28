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
      # @example Parse 'hour-minute' measurement:
      #   CompositeUnitMeasurements::Time.parse("3 h 45 min") #=> 3.75 h
      # @example Parse 'duration':
      #   CompositeUnitMeasurements::Time.parse("12:60:3600,360000000") #=> 14.1 h
      #   CompositeUnitMeasurements::Time.parse("12:60:3600") #=> 14.0 h
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
        when HOUR_MINUTE then parse_hour_minute(string)
        when DURATION    then parse_duration(string)
        else                  raise UnitMeasurements::ParseError, string
        end
      end

      private

      # @private
      # Parses a +string+ representing a time in the format of +hour-minute+
      # into a +UnitMeasurements::Time+ object.
      #
      # @param [String] string
      #   The string representing time measurement in the format of *hour-minute*.
      # @return [UnitMeasurements::Time]
      #   Returns a UnitMeasurements::Time object if parsing is successful.
      #
      # @see HOUR_MINUTE
      # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
      # @since 0.3.0
      def parse_hour_minute(string)
        hour, minute = string.match(HOUR_MINUTE)&.captures

        if hour && minute
          UnitMeasurements::Time.new(hour, "h") + UnitMeasurements::Time.new(minute, "min")
        end
      end

      # @private
      # Parses a +string+ representing time duration in the format of
      # +hour:minute:second,microsecond+ or +hour:minute:second+ into a
      # +UnitMeasurements::Time+ object.
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

    # Regex pattern for aliases of +hour+ unit.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.3.0
    HOUR_ALIASES = /(?:h|hr|hour(?:s)?)/.freeze

    # Regex pattern for aliases of +minute+ unit.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.3.0
    MINUTE_ALIASES = /(?:min|minute(?:s)?)/.freeze

    # Regex pattern for parsing a time measurement in the format of +hour-minute+.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.3.0
    HOUR_MINUTE = /\A#{ANY_NUMBER}\s*#{HOUR_ALIASES}\s*#{ANY_NUMBER}\s*#{MINUTE_ALIASES}\z/.freeze

    # Regex pattern for parsing duration in the format of +hour:minute:second+ or
    # +hour:minute:second,microsecond+.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.2.0
    DURATION = /\A(?<hour>#{REAL_NUMBER}):(?<min>#{REAL_NUMBER}):(?:(?<sec>#{REAL_NUMBER}))?(?:,(?<msec>#{REAL_NUMBER}))?\z/.freeze

    private_constant :HOUR_ALIASES, :MINUTE_ALIASES, :HOUR_MINUTE, :DURATION
  end
end
