# frozen_string_literal: true
require 'date'

#  Dates are in YYYY-MM-DD format
module HolidayCo
  module CalculateHolidays
    class Pascua
      PASCUA_HOLIDAYS = {
        "Jueves Santo" => {
          operation: :-,
          days: 3
        },
        "Viernes Santo" => {
          operation: :-,
          days: 2
        },
        "Ascención de Jesús" => {
          operation: :+,
          days: 43
        },
        "Corpus Christi" => {
          operation: :+,
          days: 64
        },
        "Sagrado Corazón de Jesús" => {
          operation: :+,
          days: 71
        }
      }

      def self.for(year)
        pascua_day = Date.parse(HolidayCo.pascua_day_per_year[year])
        PASCUA_HOLIDAYS.map do |holiday, ops|
          {
            "name" => holiday,
            "date" => pascua_day.public_send(ops[:operation], ops[:days])
          }
        end
      end
    end
  end
end
