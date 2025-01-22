require "minitest/autorun"
require_relative "../../../lib/holiday_co/models/year"

module HolidayCo
  class YearTest < Minitest::Test
    def setup
      @year = Year.new(2023)
      @invalid_year = Year.new(1982)
    end

    def test_initialize
      assert_equal "2023", @year.year
    end

    def test_holidays_with_valid_year
      holidays = @year.holidays

      refute_empty holidays
      assert_instance_of Array, holidays
    end

    def test_holidays_with_invalid_year
      assert_raises(YearDataNotAvailableError) { @invalid_year.holidays }
    end

    def test_holiday_names
      holiday_names = @year.holiday_names

      refute_empty holiday_names
      assert_instance_of Array, holiday_names
    end

    def test_holiday_dates
      holiday_dates = @year.holiday_dates

      refute_empty holiday_dates
      assert_instance_of Array, holiday_dates
    end

    def test_exception_message
      error = YearDataNotAvailableError.new

      assert_equal "There is no data file available for the specified year (yet).", error.message
    end
  end
end
