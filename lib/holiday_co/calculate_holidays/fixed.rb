# frozen_string_literal: true

module HolidayCo
  module CalculateHolidays
    # Holidays that always fall on the same calendar date, whatever day of
    # the week it is.
    #
    # Fixed.for(year) returns an array of { name:, date: } hashes, with dates
    # as "YYYY-MM-DD" strings.
    class Fixed
      FIXED_HOLIDAYS = {
        "Año Nuevo" => "%4s-01-01",
        "Día del trabajo" => "%4s-05-01",
        "Día de la independencia" => "%4s-07-20",
        "Batalla de Boyacá" => "%4s-08-07",
        "Inmaculada Concepción" => "%4s-12-08",
        "Navidad" => "%4s-12-25"
      }

      def self.for(year)
        FIXED_HOLIDAYS.map do |holiday, date|
          {
            :name => holiday,
            :date => date % year
          }
        end
      end
    end
  end
end
