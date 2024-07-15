require "date"

module HolidayCo
  # Colombian time zone is 5 hours behind UTC.
  UTC_OFFSET = "-05:00".freeze

  def self.current_time
    Time.now.getlocal(UTC_OFFSET)
  end

  def self.current_year
    current_time.year
  end

  def self.current_date
    current_time.to_date
  end

  def self.pascua_day_per_year
      # The "Día de Pascua" (aka Domingo de Resurrección) plays a crucial role in determining
      # 5 of the 18 holidays, but its calculation is quite unique. Learn more at:
      # https://blogs.elespectador.com/actualidad/algoritmo-calcular-las-fechas-la-semana-santa-ano
      # For now, I'm using precomputed dates up to 2040 (data from festivos.com.co).

      # In the future, we can implement the Gauss algorithm version.

      # TODO. Double check the days are indeed the correct ones.
      {
        "2020" => "2020-04-12", "2021" => "2021-04-04",
        "2022" => "2022-04-17", "2023" => "2023-04-09",
        "2024" => "2024-03-31", "2025" => "2025-04-20",
        "2026" => "2026-04-05", "2027" => "2027-04-28",
        "2028" => "2028-04-16", "2029" => "2029-04-01",
        "2030" => "2030-04-21", "2031" => "2031-04-13",
        "2032" => "2032-03-28", "2033" => "2033-04-17",
        "2034" => "2034-04-09", "2035" => "2035-03-25",
        "2036" => "2036-04-13", "2037" => "2037-04-05",
        "2038" => "2038-04-25", "2039" => "2039-04-10",
        "2040" => "2040-04-01"
      }
  end
end
