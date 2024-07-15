# frozen_string_literal: true
require 'date'

#  Dates are in YYYY-MM-DD format
module HolidayCo
  module CalculateHolidays
    class Movable
      using NextMondayRefinement

      # Holidays that are moved to the following Monday
      # if they don't fall on a Monday.
      MOVABLE_HOLIDAYS = {
        "Epifanía" => "%4s-01-06",
        "Día de San José" => "%4s-03-19",
        "San Pedro y San Pablo" => "%4s-06-29",
        "Asunción de la Virgen" => "%4s-08-15",
        "Día de la raza" => "%4s-10-12",
        "Todos los Santos" => "%4s-11-01",
        "Independencia de Cartagena" => "%4s-11-11"
      }

      def self.for(year)
        MOVABLE_HOLIDAYS.transform_values do |date|
          day = Date.parse(date % year)
          day.monday? ? day : day.next_monday
        end
      end
    end
  end
end

module NextMondayRefinement
  refine Date do
    def next_monday
      from_now = 1 - wday
      from_now += 7 unless from_now > 0
      self + from_now
    end
  end
end
