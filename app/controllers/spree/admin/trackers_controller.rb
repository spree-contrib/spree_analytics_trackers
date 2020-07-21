module Spree
  module Admin
    class TrackersController < ResourceController
      before_action :load_data

      private

      def load_data
        @engines = Spree::Tracker.engines.keys.sort.map { |k| [k.humanize, k] }
        @stores = Spree::Store.all
      end
    end
  end
end
