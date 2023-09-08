# frozen_string_literal: true

require "yaml"

module HolidayCo
  class YearDataNotAvailableError < StandardError
    def message
      "There is no data file available for the specified year (yet)."
    end
  end

  class Year
    attr_reader :year

    def initialize(year)
      @year = year.to_s
    end

    def holidays
      raise YearDataNotAvailableError unless year_data_available?

      YAML
        .load_file(File.expand_path("../../../../data/years/#{year}.yml", __FILE__))
        .fetch("holidays", [])
        .map { |h| h.transform_keys(&:to_sym) }
    end

    def holiday_names
      holidays.map { |h| h[:name] }
    end

    def holiday_dates
      holidays.map { |h| h[:date] }
    end

    private

    def year_data_available?
      available_years.include?(year)
    end

    def available_years
      YAML
        .load_file(File.expand_path("../../../../data/years.yml", __FILE__))
        .map(&:to_s)
    end
  end
end
