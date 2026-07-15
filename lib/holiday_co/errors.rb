# frozen_string_literal: true

module HolidayCo
  class YearDataNotAvailableError < StandardError
    def message
      "Colombian holidays can only be calculated for years #{AVAILABLE_YEARS.first} through #{AVAILABLE_YEARS.last}."
    end
  end
end
