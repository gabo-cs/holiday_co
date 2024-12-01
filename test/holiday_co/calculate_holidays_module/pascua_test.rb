require "minitest/autorun"
require_relative "../../../lib/holiday_co/calculate_holidays_module/pascua"

class PascuaTest < Minitest::Test
  def test_movable_holidays_for_year
    holidays = HolidayCo::CalculateHolidaysModule::Pascua.for(2024)

    assert_equal "2024-03-28", holidays.find { |holiday| holiday[:name] == "Jueves Santo" }[:date]
    assert_equal "2024-03-29", holidays.find { |holiday| holiday[:name] == "Viernes Santo" }[:date]
    assert_equal "2024-05-13", holidays.find { |holiday| holiday[:name] == "Ascención de Jesús" }[:date]
    assert_equal "2024-06-03", holidays.find { |holiday| holiday[:name] == "Corpus Christi" }[:date]
    assert_equal "2024-06-10", holidays.find { |holiday| holiday[:name] == "Sagrado Corazón de Jesús" }[:date]
  end

  def test_movable_holidays_for_different_year
    holidays = HolidayCo::CalculateHolidaysModule::Pascua.for(2025)

    assert_equal "2025-04-17", holidays.find { |holiday| holiday[:name] == "Jueves Santo" }[:date]
    assert_equal "2025-04-18", holidays.find { |holiday| holiday[:name] == "Viernes Santo" }[:date]
    assert_equal "2025-06-02", holidays.find { |holiday| holiday[:name] == "Ascención de Jesús" }[:date]
    assert_equal "2025-06-23", holidays.find { |holiday| holiday[:name] == "Corpus Christi" }[:date]
    assert_equal "2025-06-30", holidays.find { |holiday| holiday[:name] == "Sagrado Corazón de Jesús" }[:date]
  end

  def test_pascua_holiday_names_for_year
    holidays = HolidayCo::CalculateHolidaysModule::Pascua.for(2024)

    holiday_names = holidays.map { |holiday| holiday[:name] }
    assert_includes holiday_names, "Jueves Santo"
    assert_includes holiday_names, "Viernes Santo"
    assert_includes holiday_names, "Ascención de Jesús"
    assert_includes holiday_names, "Corpus Christi"
    assert_includes holiday_names, "Sagrado Corazón de Jesús"
  end
end
