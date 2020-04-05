module SpreeAnalyticsTrackers
  class BasePresenter
    include Rails.application.routes.url_helpers

    def initialize(resource = {}, options = {})
      @resource = resource
      @options = options
    end

    def to_json
      serialize_resource(@resource, @options).to_json
    end
  end
end
