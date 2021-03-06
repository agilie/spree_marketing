module SpreeMarketing
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option :auto_run_migrations, type: :boolean, default: false

      def add_javascripts
        append_file 'vendor/assets/javascripts/spree/frontend/all.js', "//= require spree/frontend/spree_marketing\n"
        append_file 'vendor/assets/javascripts/spree/backend/all.js', "//= require spree/backend/spree_marketing\n"
      end

      def add_stylesheets
        inject_into_file 'vendor/assets/stylesheets/spree/frontend/all.css', " *= require spree/frontend/spree_marketing\n", before: /\*\//, verbose: true
        inject_into_file 'vendor/assets/stylesheets/spree/backend/all.css', " *= require spree/backend/spree_marketing\n", before: /\*\//, verbose: true
      end

      def self.source_paths
        paths = superclass.source_paths
        paths << File.expand_path('../templates', "../../#{__FILE__}")
        paths << File.expand_path('../templates', "../#{__FILE__}")
        paths << File.expand_path('templates', __dir__)
        paths.flatten
      end

      def install_spree_events_tracker
        run 'bundle exec rails g spree_events_tracker:install'
      end

      def config_spree_marketing_yml
        template 'spree_marketing.yml', 'config/spree_marketing.yml.example'
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_marketing'
      end

      def run_migrations
        run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask('Would you like to run the migrations now? [Y/n]'))
        if run_migrations
          run 'bundle exec rake db:migrate'
        else
          puts 'Skipping rake db:migrate, don\'t forget to run it!'
        end
      end

      def add_whenever_task
        filename = 'config/schedule.rb'
        run 'wheneverize .' unless File.exist? filename

        append_file filename, <<~WHENEVER
          \n
          every 1.day, :at => '12:01 am' do
            rake 'spree_marketing:smart_list:generate'
            rake 'spree_marketing:smart_list:campaign:sync'
          end
        WHENEVER
      end
    end
  end
end
