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
      # @example Parse 'minute-second' measurement:
      #   CompositeUnitMeasurements::Time.parse("10 min 90 s") #=> 11.5 min
      # @example Parse 'week-day' measurement:
      #   CompositeUnitMeasurements::Time.parse("8 wk 3 d") #=> 8.428571428571429 wk
      # @example Parse 'month-day' measurement:
      #   CompositeUnitMeasurements::Time.parse("2 mo 60 d") #=> 3.97260057797197 mo
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
        when HOUR_MINUTE   then parse_hour_minute(string)
        when DURATION      then parse_duration(string)
        when MINUTE_SECOND then parse_minute_second(string)
        when WEEK_DAY      then parse_week_day(string)
        when MONTH_DAY     then parse_month_day(string)
        else                    raise UnitMeasurements::ParseError, string
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

        UnitMeasurements::Time.new((hour || 0), "h") +
          UnitMeasurements::Time.new((minute || 0), "min") +
          UnitMeasurements::Time.new((second || 0), "s") +
          UnitMeasurements::Time.new((microsecond || 0), "μs")
      end

      # @private
      # Parses a +string+ representing a time in the format of +minute-second+
      # into a +UnitMeasurements::Time+ object.
      #
      # @param [String] string
      #   The string representing time measurement in the format of *minute-second*.
      # @return [UnitMeasurements::Time]
      #   Returns a UnitMeasurements::Time object if parsing is successful.
      #
      # @see MINUTE_SECOND
      # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
      # @since 0.5.0
      def parse_minute_second(string)
        minute, second = string.match(MINUTE_SECOND)&.captures

        if minute && second
          UnitMeasurements::Time.new(minute, "min") + UnitMeasurements::Time.new(second, "s")
        end
      end

      # @private
      # Parses a +string+ representing a time in the format of +week-day+
      # into a +UnitMeasurements::Time+ object.
      #
      # @param [String] string
      #   The string representing time measurement in the format of *week-day*.
      # @return [UnitMeasurements::Time]
      #   Returns a UnitMeasurements::Time object if parsing is successful.
      #
      # @see WEEK_DAY
      # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
      # @since 0.5.0
      def parse_week_day(string)
        week, day = string.match(WEEK_DAY)&.captures

        if week && day
          UnitMeasurements::Time.new(week, "wk") + UnitMeasurements::Time.new(day, "d")
        end
      end

      # @private
      # Parses a +string+ representing a time in the format of +month-day+
      # into a +UnitMeasurements::Time+ object.
      #
      # @param [String] string
      #   The string representing time measurement in the format of *month-day*.
      # @return [UnitMeasurements::Time]
      #   Returns a UnitMeasurements::Time object if parsing is successful.
      #
      # @see MONTH_DAY
      # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
      # @since 0.5.0
      def parse_month_day(string)
        month, day = string.match(MONTH_DAY)&.captures

        if month && day
          UnitMeasurements::Time.new(month, "mo") + UnitMeasurements::Time.new(day, "d")
        end
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

    # Regex pattern for aliases of +second+ unit.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.5.0
    SECOND_ALIASES = /(?:s|sec|second(?:s)?)/.freeze

    # Regex pattern for aliases of +day+ unit.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.5.0
    DAY_ALIASES = /(?:d|day(?:s)?)/.freeze

    # Regex pattern for aliases of +week+ unit.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.5.0
    WEEK_ALIASES = /(?:wk|week(?:s)?)/.freeze

    # Regex pattern for aliases of +month+ unit.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.5.0
    MONTH_ALIASES = /(?:mo|month(?:s)?)/.freeze

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

    # Regex pattern for parsing a time measurement in the format of +minute-second+.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.5.0
    MINUTE_SECOND = /\A#{ANY_NUMBER}\s*#{MINUTE_ALIASES}\s*#{ANY_NUMBER}\s*#{SECOND_ALIASES}\z/.freeze

    # Regex pattern for parsing a time measurement in the format of +week-day+.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.5.0
    WEEK_DAY = /\A#{ANY_NUMBER}\s*#{WEEK_ALIASES}\s*#{ANY_NUMBER}\s*#{DAY_ALIASES}\z/.freeze

    # Regex pattern for parsing a time measurement in the format of +month-day+.
    #
    # @author {Harshal V. Ladhe}[https://shivam091.github.io/]
    # @since 0.5.0
    MONTH_DAY = /\A#{ANY_NUMBER}\s#{MONTH_ALIASES}\s*#{ANY_NUMBER}\s*#{DAY_ALIASES}\z/.freeze

    private_constant :HOUR_ALIASES, :MINUTE_ALIASES, :SECOND_ALIASES, :DAY_ALIASES,
                     :WEEK_ALIASES, :MONTH_ALIASES, :HOUR_MINUTE, :DURATION,
                     :MINUTE_SECOND, :WEEK_DAY, :MONTH_DAY
  end
end
