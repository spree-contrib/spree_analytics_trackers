module SpreeAnalyticsTrackers
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option :auto_run_migrations, type: :boolean, default: false

      def add_javascripts
        javascripts_path = 'vendor/assets/javascripts/spree/frontend/all.js'
        return unless File.file?(javascripts_path)

        append_file 'vendor/assets/javascripts/spree/frontend/all.js', "//= require spree/frontend/add_to_cart_analytics\n"
        append_file 'vendor/assets/javascripts/spree/frontend/all.js', "//= require spree/frontend/remove_from_cart_analytics\n"
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_analytics_trackers'
      end

      def run_migrations
        run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask 'Would you like to run the migrations now? [Y/n]')
        if run_migrations
          run 'bundle exec rake db:migrate'
        else
          puts 'Skipping rake db:migrate, don\'t forget to run it!'
        end
      end
    end
  end
end
