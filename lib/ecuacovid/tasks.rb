require 'ecuacovid/explorer'
require 'rake/clean'

module Ecuacovid
  class Tasks
    WORKSPACE = "tmp"

    include ::Rake::DSL if defined? ::Rake::DSL

    def Tasks.register
      new.register
    end

    def initialize
      @app = Explorer.new
      @app.reporting_ready(self)
    end

    def register
      @app.reports_available.each do |name|
        %w{ persistent in_memory }.each do |task_type|
          register_task(task_type, name)
        end
      end

      register_compound_tasks
    end

    def data_loaded
      log "Data loaded successfully!"
    end

    def display_report(contents)
      log "Loading report.. ", ""
      @report_data = contents
    end

    private
    def register_task(type, name)
      send "register_#{type}_task".to_sym, name
    end

    def register_persistent_task(name)
      desc "Saves #{name} report to disk"
      task name do
        log "Starting task #{name}.."
        @app.load_report(name.to_sym)

        log "Saving.."
  
        Dir.chdir(WORKSPACE) do
          save(name) do |content|
            log_report(content)
          end
        end
      end
    end

    def register_in_memory_task(name)
      desc "Shows #{name} partial table"
      task "#{name.to_s}_raw".to_sym do
        @app.load_report(name.to_sym)

        log_report(@report_data)
      end
    end

    def register_compound_tasks
      desc "Saves city positive cases pivoted"
      task generate_positives_cities_tabulated: [
        :positives_cities_accumulated_per_day_tabulated,
        :positives_cities_new_per_day_tabulated,
        :positives_cities_accumulated_per_week_tabulated,
        :positives_cities_new_per_week_tabulated,
        :positives_cities_accumulated_per_month_tabulated,
        :positives_cities_new_per_month_tabulated
      ]

      desc "Saves province positive cases (daily, weekly, and monthly)"
      task generate_positives_provinces: [
        :positives_provinces_accumulated_per_day,
        :positives_provinces_new_per_day,
        :positives_provinces_accumulated_per_week,
        :positives_provinces_new_per_week,
        :positives_provinces_accumulated_per_month,
        :positives_provinces_new_per_month  
      ]

      desc "Saves province positive cases pivoted"
      task generate_positives_provinces_tabulated: [
        :positives_provinces_accumulated_per_day_tabulated,
        :positives_provinces_new_per_day_tabulated,
        :positives_provinces_accumulated_per_week_tabulated,
        :positives_provinces_new_per_week_tabulated,
        :positives_provinces_accumulated_per_month_tabulated,
        :positives_provinces_new_per_month_tabulated
      ]

      desc "Saves province death cases (weekly and monthly)"
      task generate_deaths_provinces: [
        :deaths_provinces_accumulated_per_week,
        :deaths_provinces_new_per_week,
        :deaths_provinces_accumulated_per_month,
        :deaths_provinces_new_per_month
      ]

      desc "Saves province death cases pivoted"
      task generate_deaths_provinces_tabulated: [
        :deaths_provinces_accumulated_per_day_tabulated,
        :deaths_provinces_new_per_day_tabulated,
        :deaths_provinces_accumulated_per_week_tabulated,
        :deaths_provinces_new_per_week_tabulated,
        :deaths_provinces_accumulated_per_month_tabulated,
        :deaths_provinces_new_per_month_tabulated
      ]

      desc "Saves city all cause mortality cases pivoted (daily and monthly)"
      task generate_mortalities_cities_tabulated: [
        :mortalities_cities_accumulated_per_day_tabulated,
        :mortalities_cities_new_per_day_tabulated,
        :mortalities_cities_accumulated_per_month_tabulated,
        :mortalities_cities_new_per_month_tabulated
      ]

      desc "Saves city all cause mortality cases pivoted (weekly)"
      task generate_mortalities_cities_weekly_tabulated: [
        :mortalities_cities_accumulated_per_week_tabulated,
        :mortalities_cities_new_per_week_tabulated
      ]

      desc "Saves province mortality cases (daily and monthly)"
      task generate_mortalities_provinces: [
        :mortalities_provinces_accumulated_per_day,
        :mortalities_provinces_new_per_day,
        :mortalities_provinces_accumulated_per_month,
        :mortalities_provinces_new_per_month
      ]

      desc "Saves province mortality cases (weekly)"
      task generate_mortalities_provinces_weekly: [
        :mortalities_provinces_accumulated_per_week,
        :mortalities_provinces_new_per_week
      ]

      desc "Saves province all cause mortality cases pivoted (daily and monthly)"
      task generate_mortalities_provinces_tabulated: [
        :mortalities_provinces_accumulated_per_day_tabulated,
        :mortalities_provinces_new_per_day_tabulated,
        :mortalities_provinces_accumulated_per_month_tabulated,
        :mortalities_provinces_new_per_month_tabulated
      ]

      desc "Saves province all cause mortality cases pivoted (weekly)"
      task generate_mortalities_provinces_weekly_tabulated: [
        :mortalities_provinces_accumulated_per_week_tabulated,
        :mortalities_provinces_new_per_week_tabulated
      ]
    end
  
    def log(msg, endl = "\n")
      print "#{msg}#{endl}"
    end
      
    def log_report(data)
      report = data.split("\n")
      msg = ["Done!"] << "\n\n"
      msg << "Examining partial sample result table: " << "\n"
      msg << "#{'*' * 100}" << "\n"
      msg << report.first.chars.take(100).join << "\n"
      msg << "#{'*' * 100}" << "\n"
      msg << report[1..].sample(20).map {|s| s.chars.take(100).join }.join("\n") << "\n"
        
      log(msg.join)
    end
      
    def save(name, &block)
      source_file = File.expand_path("#{name}.csv", Dir.pwd)
      
      File.delete(source_file) if File.exist?(source_file)
      
      File.open(source_file, "w") do |f|
        f.puts(@report_data)
        yield(@report_data) if block_given?
      end
    end
  end
end

Ecuacovid::Tasks.register
CLOBBER.include %w{positives deaths mortalities}.map {|s| "#{Ecuacovid::Tasks::WORKSPACE}/#{s}*.csv"}
