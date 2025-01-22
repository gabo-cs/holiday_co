require "minitest/autorun"
require_relative "../../../lib/holiday_co/calculate_holidays_module/fixed"

class CalculateHolidaysModuleTest < Minitest::Test
  def test_fixed_holidays_for_year
    holidays = HolidayCo::CalculateHolidaysModule::Fixed.for(2024)

    assert holidays.is_a?(Array)
    assert holidays.length >= 6

    assert_equal "2024-01-01", holidays.find { |holiday| holiday[:name] == "Año Nuevo" }[:date]
    assert_equal "2024-05-01", holidays.find { |holiday| holiday[:name] == "Día del trabajo" }[:date]
    assert_equal "2024-07-20", holidays.find { |holiday| holiday[:name] == "Día de la independencia" }[:date]
    assert_equal "2024-08-07", holidays.find { |holiday| holiday[:name] == "Batalla de Boyacá" }[:date]
    assert_equal "2024-12-08", holidays.find { |holiday| holiday[:name] == "Inmaculada Concepción" }[:date]
    assert_equal "2024-12-25", holidays.find { |holiday| holiday[:name] == "Navidad" }[:date]
  end

  def test_fixed_holidays_for_different_year
    holidays = HolidayCo::CalculateHolidaysModule::Fixed.for(2025)

    assert_equal "2025-01-01", holidays.find { |holiday| holiday[:name] == "Año Nuevo" }[:date]
    assert_equal "2025-05-01", holidays.find { |holiday| holiday[:name] == "Día del trabajo" }[:date]
    assert_equal "2025-07-20", holidays.find { |holiday| holiday[:name] == "Día de la independencia" }[:date]
    assert_equal "2025-08-07", holidays.find { |holiday| holiday[:name] == "Batalla de Boyacá" }[:date]
    assert_equal "2025-12-08", holidays.find { |holiday| holiday[:name] == "Inmaculada Concepción" }[:date]
    assert_equal "2025-12-25", holidays.find { |holiday| holiday[:name] == "Navidad" }[:date]
  end

  def test_holiday_names_for_year
    holidays = HolidayCo::CalculateHolidaysModule::Fixed.for(2024)

    holiday_names = holidays.map { |holiday| holiday[:name] }
    assert_includes holiday_names, "Año Nuevo"
    assert_includes holiday_names, "Día del trabajo"
    assert_includes holiday_names, "Día de la independencia"
    assert_includes holiday_names, "Batalla de Boyacá"
    assert_includes holiday_names, "Inmaculada Concepción"
    assert_includes holiday_names, "Navidad"
  end
end
