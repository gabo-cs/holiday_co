require "date"
require_relative "year"

module HolidayCo
  class Day
    attr_reader :date

    def initialize(date)
      @date = date.to_s
    end

    def holiday?
      holiday_dates.include?(date)
    end

    private

    def holiday_dates
      Year.new(Date.parse(date).year).holiday_dates
    end
  end
end
