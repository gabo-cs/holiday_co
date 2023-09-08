require "minitest/autorun"
require_relative "../../../lib/holiday_co/models/year"
require_relative "../../../lib/holiday_co/models/day"

module HolidayCo
  class DayTest < Minitest::Test
    def setup
      @year = Year.new(2023)
      @holiday_dates = @year.holiday_dates
    end

    def test_initialize
      date = Date.new(2023, 12, 25)
      day = Day.new(date)

      assert_equal "2023-12-25", day.date
    end

    def test_holiday_with_holiday_date
      holiday_date = @holiday_dates.first
      day = Day.new(holiday_date)

      assert day.holiday?
    end

    def test_holiday_with_non_holiday_date
      non_holiday_date = Date.new(2023, 1, 15)
      day = Day.new(non_holiday_date)

      refute day.holiday?
    end
  end
end
