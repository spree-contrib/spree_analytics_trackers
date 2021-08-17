module SpreeAnalyticsTrackers
  module_function

  # Returns the version of the currently loaded SpreeAnalyticsTrackers as a
  # <tt>Gem::Version</tt>.
  def version
    Gem::Version.new VERSION::STRING
  end

  module VERSION
    MAJOR = 2
    MINOR = 1
    TINY  = 22
    PRE   = 'rc1'

    STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')
  end
end
