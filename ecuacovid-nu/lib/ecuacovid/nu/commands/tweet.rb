require "nu_plugin/command"
require 'ecuacovid/utils/string'

module Ecuacovid
  module Nu
    require 'ecuacovid/highest_seven_daily_cases'

    class Tweet < NuPlugin::Command
      attr_reader :region

      name "ecuacovid tweet"
      usage "Tweet reports"

      optional :report, desc: "Report desired." do
        type String
        short "r"

        present {|which| @report = which.to_sym}
      end

      optional :region, desc: "Region desired (cities/provinces)" do
        type String
        short "a"

        present {|area| @region = area.to_sym }
      end

      def initialize
        @app = Nu.app
        @app.view = self

        @region = :cities
        @messages = []
      end

      def reports_available
        [HighestDailyCases, HighestMortalities2, HighestSevenDailyCases]
      end
    
      def sink
        usage! if report_not_found?
        start
        done
      end

      def tweet(message)
        @messages << message
      end

      private
      def usage!
        print(reports_available.map(&:name).join(","))
        exit
      end

      def report_not_found?
        !args.report? || reports_available.map(&:name).find {|r| r == @report}.nil? && @report != :all
      end

      def start
        options = {
          app: @app,
          view: self
        }

        if @report == :all
          run_all(options)
        else
          run_report(options)
        end
      end

      def run_all(options)
        reports_available.each {|r| r.new(options)}
      end

      def run_report(options)
        reports_available.find {|r| r.name == @report}.new(options)
      end

      def done
        print @messages.join("\n\n")
      end
    end
  end
end
