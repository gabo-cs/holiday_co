require "minitest/autorun"
require_relative "../lib/holiday_co"

class HolidayCoTest < Minitest::Test
  def test_holidays_from_yaml_in_the_default_year
    holidays = HolidayCo.holidays

    assert holidays.is_a?(Array)
    assert holidays[0].is_a?(Hash)
    assert_equal "Año Nuevo", holidays[0][:name]
    assert_equal "Navidad", holidays[-1][:name]
  end

  def test_holidays_from_yaml_in_a_given_year
    holidays = HolidayCo.holidays("2023")

    assert_equal "Batalla de Boyacá", holidays[11][:name]
    assert_equal "2023-08-07", holidays[11][:date]
  end

  def test_holiday
    assert HolidayCo.is_holiday?("2023-01-01")
  end

  def test_not_holiday
    refute HolidayCo.is_holiday?("2023-01-02")
  end

  def test_holiday_in_a_valid_future_year
    assert HolidayCo.is_holiday?("2024-01-01")
  end

  def test_not_holiday_in_a_valid_future_year
    refute HolidayCo.is_holiday?("2024-01-02")
  end

  def test_holiday_in_an_invalid_future_year
    assert_raises(HolidayCo::YearDataNotAvailableError) do
      HolidayCo.is_holiday?("2028-01-01")
    end
  end

  def test_not_holiday_in_an_invalid_future_year
    assert_raises(HolidayCo::YearDataNotAvailableError) do
      HolidayCo.is_holiday?("2028-01-02")
    end
  end

  def test_holiday_in_an_invalid_past_year
    assert_raises(HolidayCo::YearDataNotAvailableError) do
      HolidayCo.is_holiday?("1999-01-01")
    end
  end

  def test_not_holiday_in_an_invalid_past_year
    assert_raises(HolidayCo::YearDataNotAvailableError) do
      HolidayCo.is_holiday?("1999-01-02")
    end
  end

  def test_holiday_names
    holiday_names = HolidayCo.holidays_names(2023)

    assert holiday_names.include?("Año Nuevo")
    assert holiday_names.include?("Viernes Santo")
  end

  def test_holiday_dates
    holiday_dates = HolidayCo.holidays_dates(2024)

    assert holiday_dates.include?("2024-01-01")
    assert holiday_dates.include?("2024-03-29")
  end
end
