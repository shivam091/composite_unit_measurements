# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

# This module provides parsers and utilities for handling composite unit measurements.
# It allows parsing and manipulation of various composite measurements for units of
# +length+, +weight+, +time+ etc.
#
# @note
#   This module serves as a namespace for classes and utilities related to composite
#   unit measurements. To parse such measurements, refer to individual classes like
#   {Length}, {Weight}, {Time}, etc. within this module.
#
# @example
#   CompositeUnitMeasurements::Length.parse("5 feet 12 inches")
#   => 6.0 ft
#
#   CompositeUnitMeasurements::Weight.parse("8 lb 12 oz")
#   => 8.75 lb
#
#   CompositeUnitMeasurements::Time.parse("3 h 45 min")
#   => 3.75 h
#
# @author {Harshal V. Ladhe}[https://shivam091.github.io/]
# @since 0.1.0
module CompositeUnitMeasurements
  # Current stable version
  VERSION = "0.2.0"
end
