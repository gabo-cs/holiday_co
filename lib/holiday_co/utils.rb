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
end
