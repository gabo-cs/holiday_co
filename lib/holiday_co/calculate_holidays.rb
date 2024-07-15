# frozen_string_literal: true

# Source of Calculation Rules: https://www.festivos.com.co/calculo
module HolidayCo
  class CalculateHolidays
    attr_reader :year

    def self.for(year)
      new(year).calculate
    end

    def initialize(year)
      @year = year
    end

    def calculate
      raise SisaColeError unless some_validation?

      fixed_holidays + pascua_holidays + movable_holidays
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
