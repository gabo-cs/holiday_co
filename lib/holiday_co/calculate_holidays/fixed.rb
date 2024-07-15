# frozen_string_literal: true

#  Dates are in YYYY-MM-DD format
module HolidayCo
  module CalculateHolidays
    class Fixed
      FIXED_HOLIDAYS = {
        "Año Nuevo" => "%4s-01-01",
        "Día del trabajo" => "%4s-05-01",
        "Batalla de Boyacá" => "%4s-08-07",
        "Día de la independencia" => "%4s-07-20",
        "Inmaculada Concepción" => "%4s-12-08",
        "Navidad" => "%4s-12-25"
      }

      def self.for(year)
        FIXED_HOLIDAYS.transform_values { |date| date % year }
      end
    end
  end
end
