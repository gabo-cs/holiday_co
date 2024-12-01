require "date"

module HolidayCo
  # Colombian time zone is 5 hours behind UTC.
  UTC_OFFSET = "-05:00".freeze

  # Colombian Holidays started in 1983
  AVAILABLE_YEARS = (1983..9999).freeze

  def self.current_time
    Time.now.getlocal(UTC_OFFSET)
  end

  def self.current_year
    current_time.year
  end

  def self.current_date
    current_time.to_date
  end

  def self.pascua_day_per_year(year)
    calculate_pascua_day_per_year(year)
  end

  private

  def self.calculate_pascua_day_per_year(year)
    # The "Día de Pascua" (aka Domingo de Resurrección) plays a crucial role in determining
    # 5 of the 18 holidays, but its calculation is unique. For more details, check out:
    # https://blogs.elespectador.com/actualidad/algoritmo-calcular-las-fechas-la-semana-santa-ano
    # This calculation is based on an astronomical algorithm that takes into account the lunar cycle,
    # leap years, and the position of weekdays, which is used to calculate the exact date of
    # pascua each year

    lunar_cycle_position = year % 19 # a: Position in the lunar cycle
    leap_year_indicator = year % 4  # b: Leap year indicator
    week_day_position = year % 7    # c: Day of the week

    century = year / 100            # d: Century of the year
    leap_year_adjustment = (13 + 8 * century) / 25  # e: Adjustment for leap years in centuries
    century_quarters = century / 4  # m: Adjustment for century quarters

    lunar_adjustment = (15 - leap_year_adjustment + century - century_quarters) % 30  # n: Lunar adjustment for Easter date
    weekday_adjustment = (4 + century - century_quarters) % 7  # p: Adjustment for weekday of March 22

    march_22_offset = (19 * lunar_cycle_position + lunar_adjustment) % 30  # q: Lunar cycle position and adjustment

    final_weekday_adjustment = (
      (2 * leap_year_indicator) +
      (4 * week_day_position) +
      (6 * march_22_offset) +
      weekday_adjustment
    ) % 7  # r: Final weekday adjustment

    pascua_offset = march_22_offset + final_weekday_adjustment
    day, month = calculate_pascua_offset(pascua_offset)
    day = adjust_day_for_pascua(day, month, march_22_offset, final_weekday_adjustment, lunar_cycle_position)

    generate_pascua_date(year, month, day)
  end

  def self.calculate_pascua_offset(pascua_offset)
    pascua_offset <= 9 ? [pascua_offset + 22, "03"] : [pascua_offset - 9, "04"]
  end

  def self.exception_date?(day, month)
    [26, 25].include?(day) && month == "04"
  end

  def self.pascua_correction?(day, march_22_offset, days_to_sunday, lunar_cycle_position)
    day == 26 || march_22_offset == 28 && days_to_sunday == 6 && lunar_cycle_position > 10
  end

  def self.adjust_day_for_pascua(day, month, march_22_offset, days_to_sunday, lunar_cycle_position)
    return day unless exception_date?(day, month)
    return day unless pascua_correction?(day, march_22_offset, days_to_sunday, lunar_cycle_position)

    day -= 7
  end

  def self.generate_pascua_date(year, month, day)
    { "#{year}" => "#{year}-#{month}-#{format('%02d', day)}" }
  end
end
