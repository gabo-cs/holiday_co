require "date"
require "minitest/autorun"
require_relative "../../lib/holiday_co"

class UtilsTest < Minitest::Test
  def test_current_time
    assert_instance_of Time, HolidayCo.current_time
  end

  def test_current_year
    expected_year = Time.now.getlocal(HolidayCo::UTC_OFFSET).year
    assert_equal expected_year, HolidayCo.current_year
  end

  def test_current_date
    expected_date = Time.now.getlocal(HolidayCo::UTC_OFFSET).to_date
    assert_equal expected_date, HolidayCo.current_date
  end

  def test_pascua_day_per_year_valid_year
    result = HolidayCo.pascua_day_per_year(2024)
    assert_equal "2024-03-31", result["2024"]

    result = HolidayCo.pascua_day_per_year(2025)
    assert_equal "2025-04-20", result["2025"]

    result = HolidayCo.pascua_day_per_year(2050)
    assert_equal "2050-04-10", result["2050"]
  end

  def test_pascua_day_per_year_invalid_year
    assert_raises(HolidayCo::YearDataNotAvailableError) { HolidayCo.pascua_day_per_year(10000) }
    assert_raises(HolidayCo::YearDataNotAvailableError) { HolidayCo.pascua_day_per_year(1982) }
  end
end
