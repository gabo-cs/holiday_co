require "minitest/autorun"
require_relative "../../lib/holiday_co"

class CacheTest < Minitest::Test
  def setup
    HolidayCo.cache_enabled = true
    HolidayCo.clear_cache!
  end

  def test_fetch_only_computes_once_per_key
    cache = HolidayCo::Cache.new(max_size: 2)
    calls = 0

    2.times { cache.fetch(:a) { calls += 1 } }

    assert_equal 1, calls
    assert_equal 1, cache.fetch(:a) { flunk "should have been cached" }
  end

  def test_evicts_least_recently_used_key
    cache = HolidayCo::Cache.new(max_size: 2)
    cache.fetch(:a) { 1 }
    cache.fetch(:b) { 2 }
    cache.fetch(:a) { flunk ":a should be cached" } # touch :a, making :b the oldest
    cache.fetch(:c) { 3 } # evicts :b

    assert_equal 2, cache.size
    cache.fetch(:a) { flunk ":a should have survived eviction" }
    recalculated = false
    cache.fetch(:b) { recalculated = true }
    assert recalculated, ":b should have been evicted"
  end

  def test_rejects_invalid_max_size
    assert_raises(ArgumentError) { HolidayCo::Cache.new(max_size: 0) }
    assert_raises(ArgumentError) { HolidayCo::Cache.new(max_size: "10") }
  end

  def test_holidays_are_cached_per_year
    assert_same HolidayCo.holidays(1990), HolidayCo.holidays(1990)
  end

  def test_cached_holidays_are_deep_frozen
    holidays = HolidayCo.holidays(1991)

    assert holidays.frozen?
    assert(holidays.all? { |h| h.frozen? && h[:name].frozen? && h[:date].frozen? })
  end

  def test_caching_can_be_disabled
    HolidayCo.configure { |config| config.cache_enabled = false }

    refute_same HolidayCo.holidays(1992), HolidayCo.holidays(1992)
  ensure
    HolidayCo.cache_enabled = true
  end

  def test_clear_cache
    holidays = HolidayCo.holidays(1993)
    HolidayCo.clear_cache!

    refute_same holidays, HolidayCo.holidays(1993)
  end

  def test_cache_size_is_configurable
    HolidayCo.configure { |config| config.cache_size = 2 }

    holidays = HolidayCo.holidays(1994)
    HolidayCo.holidays(1995)
    HolidayCo.holidays(1996) # evicts 1994

    refute_same holidays, HolidayCo.holidays(1994)
  ensure
    HolidayCo.cache_size = HolidayCo::Cache::DEFAULT_MAX_SIZE
  end

  def test_fetch_is_thread_safe
    cache = HolidayCo::Cache.new(max_size: 8)

    8.times.map do
      Thread.new { 100.times { |i| cache.fetch(i % 8) { i % 8 } } }
    end.each(&:join)

    assert_equal 8, cache.size
  end
end
