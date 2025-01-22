require "minitest/autorun"
require_relative "../../../lib/holiday_co/calculate_holidays_module/movable"

class CalculateHolidaysModuleMovableTest < Minitest::Test
  def test_movable_holidays_for_year
    holidays = HolidayCo::CalculateHolidaysModule::Movable.for(2024)

    assert holidays.is_a?(Array)
    assert holidays.length >= 7

    assert_equal "2024-01-08", holidays.find { |holiday| holiday[:name] == "Epifanía" }[:date]
    assert_equal "2024-03-25", holidays.find { |holiday| holiday[:name] == "Día de San José" }[:date]
    assert_equal "2024-07-01", holidays.find { |holiday| holiday[:name] == "San Pedro y San Pablo" }[:date]
    assert_equal "2024-08-19", holidays.find { |holiday| holiday[:name] == "Asunción de la Virgen" }[:date]
    assert_equal "2024-10-14", holidays.find { |holiday| holiday[:name] == "Día de la raza" }[:date]
    assert_equal "2024-11-04", holidays.find { |holiday| holiday[:name] == "Todos los Santos" }[:date]
    assert_equal "2024-11-11", holidays.find { |holiday| holiday[:name] == "Independencia de Cartagena" }[:date]
  end

  def test_movable_holidays_for_different_year
    holidays = HolidayCo::CalculateHolidaysModule::Movable.for(2025)

    assert_equal "2025-01-06", holidays.find { |holiday| holiday[:name] == "Epifanía" }[:date]
    assert_equal "2025-03-24", holidays.find { |holiday| holiday[:name] == "Día de San José" }[:date]
    assert_equal "2025-06-30", holidays.find { |holiday| holiday[:name] == "San Pedro y San Pablo" }[:date]
    assert_equal "2025-08-18", holidays.find { |holiday| holiday[:name] == "Asunción de la Virgen" }[:date]
    assert_equal "2025-10-13", holidays.find { |holiday| holiday[:name] == "Día de la raza" }[:date]
    assert_equal "2025-11-03", holidays.find { |holiday| holiday[:name] == "Todos los Santos" }[:date]
    assert_equal "2025-11-17", holidays.find { |holiday| holiday[:name] == "Independencia de Cartagena" }[:date]
  end

  def test_movable_holidays_for_non_monday_holidays
    holidays = HolidayCo::CalculateHolidaysModule::Movable.for(2024)

    assert_equal "2024-01-08", holidays.find { |holiday| holiday[:name] == "Epifanía" }[:date]
    assert_equal "2024-03-25", holidays.find { |holiday| holiday[:name] == "Día de San José" }[:date]
    assert_equal "2024-07-01", holidays.find { |holiday| holiday[:name] == "San Pedro y San Pablo" }[:date]
    assert_equal "2024-08-19", holidays.find { |holiday| holiday[:name] == "Asunción de la Virgen" }[:date]
    assert_equal "2024-10-14", holidays.find { |holiday| holiday[:name] == "Día de la raza" }[:date]
    assert_equal "2024-11-04", holidays.find { |holiday| holiday[:name] == "Todos los Santos" }[:date]
  end

  def test_movable_holiday_names_for_year
    holidays = HolidayCo::CalculateHolidaysModule::Movable.for(2024)

    holiday_names = holidays.map { |holiday| holiday[:name] }
    assert_includes holiday_names, "Epifanía"
    assert_includes holiday_names, "Día de San José"
    assert_includes holiday_names, "San Pedro y San Pablo"
    assert_includes holiday_names, "Asunción de la Virgen"
    assert_includes holiday_names, "Día de la raza"
    assert_includes holiday_names, "Todos los Santos"
    assert_includes holiday_names, "Independencia de Cartagena"
  end
end
