require "minitest/autorun"
require_relative "../lib/holiday_co"

class HolidayCoTest < Minitest::Test
  def test_holiday
    assert HolidayCo.is_holiday?("2023-01-01")
  end

  def test_holiday_with_date_param
    assert HolidayCo.is_holiday?(Date.new(2023, 01, 01))
  end

  def test_holiday_alias
    assert_equal HolidayCo.holiday?, HolidayCo.is_holiday?
    assert_equal HolidayCo.holiday?("2023-01-01"), HolidayCo.is_holiday?("2023-01-01")
    assert_equal HolidayCo.holiday?(Date.new(2025, 01, 01)), HolidayCo.is_holiday?(Date.new(2025, 01, 01))
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
      HolidayCo.is_holiday?("10000-01-01")
    end
  end

  def test_not_holiday_in_an_invalid_future_year
    assert_raises(HolidayCo::YearDataNotAvailableError) do
      HolidayCo.is_holiday?("10000-01-02")
    end
  end

  def test_holiday_in_an_invalid_past_year
    assert_raises(HolidayCo::YearDataNotAvailableError) do
      HolidayCo.is_holiday?("1982-01-01")
    end
  end

  def test_not_holiday_in_an_invalid_past_year
    assert_raises(HolidayCo::YearDataNotAvailableError) do
      HolidayCo.is_holiday?("1982-01-02")
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
