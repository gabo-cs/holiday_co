# frozen_string_literal: true

require_relative "../errors"
require_relative "../holiday_calculator"

module HolidayCo
  class Year
    attr_reader :year

    def initialize(year)
      @year = year.to_s
    end

    def holidays
      raise YearDataNotAvailableError unless year_data_available?

      HolidayCalculator.for(year)
    end

    def holiday_names
      holidays.map { |h| h[:name] }
    end

    def holiday_dates
      holidays.map { |h| h[:date] }
    end

    private

    def year_data_available?
      available_years.include?(year.to_i)
    end

    def available_years
      HolidayCo::AVAILABLE_YEARS
    end
  end
end
