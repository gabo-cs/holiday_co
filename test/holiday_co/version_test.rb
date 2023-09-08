require "minitest/autorun"
require_relative "../../lib/holiday_co"

class VersionTest < Minitest::Test
  def test_version_presence
    refute_nil HolidayCo::VERSION
  end
end
