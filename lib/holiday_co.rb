# frozen_string_literal: true

require_relative "holiday_co/utils"
require_relative "holiday_co/version"
require_relative "holiday_co/models/day"
require_relative "holiday_co/models/year"

module HolidayCo
  class << self
    def is_holiday?(date = current_date)
      Day.new(date).holiday?
    end

    def holidays(year = current_year)
      Year.new(year).holidays
    end

    def holidays_names(year = current_year)
      Year.new(year).holiday_names
    end

    def holidays_dates(year = current_year)
      Year.new(year).holiday_dates
    end
  end
end
