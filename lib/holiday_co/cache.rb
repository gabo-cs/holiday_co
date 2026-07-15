# frozen_string_literal: true

module HolidayCo
  # A tiny thread-safe LRU cache used to memoize per-year holiday calculations,
  # so holidays are only ever calculated once per year per process.
  class Cache
    DEFAULT_MAX_SIZE = 64

    attr_reader :max_size

    def initialize(max_size: DEFAULT_MAX_SIZE)
      raise ArgumentError, "max_size must be a positive integer" unless max_size.is_a?(Integer) && max_size.positive?

      @max_size = max_size
      @store = {}
      @mutex = Mutex.new
    end

    def fetch(key)
      @mutex.synchronize do
        if @store.key?(key)
          # Re-insert on hit so insertion order tracks recency.
          @store[key] = @store.delete(key)
        else
          value = yield
          @store[key] = value
          @store.shift while @store.size > @max_size
          value
        end
      end
    end

    def size
      @mutex.synchronize { @store.size }
    end

    def clear!
      @mutex.synchronize { @store.clear }
      nil
    end
  end

  class << self
    attr_writer :cache_enabled
    attr_reader :cache_size

    def configure
      yield self if block_given?
    end

    def cache_enabled?
      @cache_enabled
    end

    def cache_size=(size)
      @cache_size = size
      @cache = nil
    end

    def cache
      @cache ||= Cache.new(max_size: cache_size)
    end

    def clear_cache!
      cache.clear!
    end
  end

  @cache_enabled = true
  @cache_size = Cache::DEFAULT_MAX_SIZE
end
