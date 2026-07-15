# frozen_string_literal: true

require "date"

module NextMondayRefinement
  refine Date do
    def next_monday
      from_now = 1 - wday
      from_now += 7 unless from_now > 0
      self + from_now
    end
  end
end

#  Dates are in YYYY-MM-DD format
module HolidayCo
  module CalculateHolidays
    class Movable
      using NextMondayRefinement

      # Holidays that are moved to the following Monday
      # if they don"t fall on a Monday.
      MOVABLE_HOLIDAYS = {
        "Epifanía" => "%4s-01-06",
        "Día de San José" => "%4s-03-19",
        "San Pedro y San Pablo" => "%4s-06-29",
        "Día de la Virgen del Rosario de Chiquinquirá" => "%4s-07-09",
        "Asunción de la Virgen" => "%4s-08-15",
        "Día de la raza" => "%4s-10-12",
        "Todos los Santos" => "%4s-11-01",
        "Independencia de Cartagena" => "%4s-11-11"
      }

      # Holidays introduced after 1983, keyed by the first year they apply.
      # Ley 2578 de 2026 declared the Día de la Virgen del Rosario de Chiquinquirá.
      EFFECTIVE_SINCE = {
        "Día de la Virgen del Rosario de Chiquinquirá" => 2026
      }

      def self.for(year)
        MOVABLE_HOLIDAYS.filter_map do |holiday, date|
          next if year.to_i < EFFECTIVE_SINCE.fetch(holiday, 0)

          day = Date.parse(date % year)
          date = day.monday? ? day : day.next_monday
          {
            :name => holiday,
            :date => date.to_s
          }
        end
      end
    end
  end
end
