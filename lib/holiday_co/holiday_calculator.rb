# frozen_string_literal: true

require_relative 'calculate_holidays/fixed'
require_relative 'calculate_holidays/movable'
require_relative 'calculate_holidays/pascua'

# Source of Calculation Rules: https://www.festivos.com.co/calculo
module HolidayCo
  class HolidayCalculator
    attr_reader :year

    def self.for(year)
      new(year).calculate
    end

    def initialize(year)
      @year = year
    end

    def calculate
      [fixed_holidays, pascua_holidays, movable_holidays]
        .flatten
        .sort_by! { |h| h[:date]}
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
