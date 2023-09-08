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
end
