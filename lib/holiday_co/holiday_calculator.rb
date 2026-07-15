# frozen_string_literal: true

require_relative 'cache'
require_relative 'calculate_holidays/fixed'
require_relative 'calculate_holidays/movable'
require_relative 'calculate_holidays/pascua'

# Source of Calculation Rules: https://www.festivos.com.co/calculo
module HolidayCo
  class HolidayCalculator
    attr_reader :year

    def self.for(year)
      year = year.to_i
      return new(year).calculate unless HolidayCo.cache_enabled?

      HolidayCo.cache.fetch(year) { new(year).calculate }
    end

    def initialize(year)
      @year = year
    end

    # Results are deep-frozen: they are shared through the cache across
    # callers and threads, so they must be immutable.
    def calculate
      [fixed_holidays, pascua_holidays, movable_holidays]
        .flatten
        .sort_by! { |h| h[:date] }
        .each { |h| h[:date].freeze; h.freeze }
        .freeze
    end

    private

    def fixed_holidays
      HolidayCo::CalculateHolidays::Fixed.for(year)
    end

    def pascua_holidays
      HolidayCo::CalculateHolidays::Pascua.for(year)
    end

    def movable_holidays
      HolidayCo::CalculateHolidays::Movable.for(year)
    end
  end
end
