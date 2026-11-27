# frozen_string_literal: true

require "date"
require_relative "../utils"

module HolidayCo
  module CalculateHolidays
    # Holidays set relative to Easter Sunday (Domingo de Pascua), which
    # changes every year. See HolidayCo.pascua_day_per_year for how it's
    # calculated.
    #
    # Each holiday is a fixed number of days before or after Easter. The
    # offsets after Easter already include the Ley Emiliani shift to Monday:
    # Ascensión is Easter + 39 days, which is a Thursday, and is observed on
    # the following Monday, Easter + 43.
    #
    # Pascua.for(year) returns an array of { name:, date: } hashes, with
    # dates as "YYYY-MM-DD" strings.
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
        pascua_day = Date.parse(HolidayCo.pascua_day_per_year(year.to_i)[year.to_s])
        PASCUA_HOLIDAYS.map do |holiday, ops|
          {
            :name => holiday,
            :date => pascua_day.public_send(ops[:operation], ops[:days]).to_s
          }
        end
      end
    end
  end
end
