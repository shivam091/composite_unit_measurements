# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

require "unit_measurements/base"

require "composite_unit_measurements/version"

module CompositeUnitMeasurements
  # Matches real numbers in the form of 31, +72, or -12.
  REAL_NUMBER = /
    (?:                   # Start of non-capturing group
      [+-]?               # Optional plus (+) or minus (-) sign
      \d+                 # One or more digits
    )                     # End of non-capturing group
  /x.freeze

  # Matches a rational number in the form of a/b (fractional) or a b/c (mixed fractional).
  RATIONAL_NUMBER = /
    (?:                   # Start of optional non-capturing group
      [+-]?               # Optional plus (+) or minus (-) sign
      \d+                 # One or more digits
      \s+                 # One or more whitespace
    )?                    # End of optional non-capturing group
    (                     # Start of capturing group for the fraction
      (\d+)               # Capture the numerator (one or more digits)
      \/                  # Match the forward slash, indicating division
      (\d+)               # Capture the denominator (one or more digits)
    )                     # End of capturing group for the fraction
  /x.freeze

  # Matches a scientific number in various formats like 1.23E+4 or -5.67e-8.
  SCIENTIFIC_NUMBER = /
    (?:                   # Start of non-capturing group
      [+-]?               # Optional plus (+) or minus (-) sign
      \d*                 # Zero or more digits (integer part)
      \.?                 # Optional decimal point
      \d+                 # One or more digits (fractional part)
      (?:                 # Start of non-capturing group for exponent part
        [Ee]              # Match 'E' or 'e' for exponentiation
        [+-]?             # Optional plus (+) or minus (-) sign for exponent
        \d+               # One or more digits (exponent value)
      )?                  # End of non-capturing group of exponent part (optional)
    )                     # End of non-capturing group
  /x.freeze

  # Matches complex numbers in the form of a+bi, where both 'a' and 'b' can be
  # in scientific notation. It captures the real and imaginary parts.
  COMPLEX_NUMBER = /
    #{SCIENTIFIC_NUMBER}  # Pattern for scientific number
    #{SCIENTIFIC_NUMBER}  # Pattern for scientific number
    i                     # Match the letter 'i' (the imaginary unit)
  /x.freeze

  # Matches any number, including scientific, complex, rational, and real numbers.
  ANY_NUMBER = /(?<number>#{SCIENTIFIC_NUMBER}|#{COMPLEX_NUMBER}|#{RATIONAL_NUMBER}|#{REAL_NUMBER})/.freeze
end
