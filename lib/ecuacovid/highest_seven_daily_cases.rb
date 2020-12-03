module Ecuacovid
  class HighestSevenDailyCases
    require 'ecuacovid/utils/objectable'
    require 'ecuacovid/utils/string'

    class << self
      def name
        :positives_cities_highest_cases_per_seventh_day
      end
    end

    def initialize(options={})
      @app = options[:app]
      @view = options[:view]
      @region = @view.region

      @app.view = self
      @app.load_report(:positives_cities_accumulated_per_day_tabulated)
    end

    def display_report(contents)
      @contents = contents
      send(@region)
      sort
      @view.tweet(format)
    end

    def cities
      @contents = @contents.flatten.map {|r| r.transform_keys(&:to_sym).to_objectable}.map do |record|
        city = record.canton
        province = record.provincia

        last_7 = record.keys[-8..]

        first_day = record[last_7.first]
        last_day  = record[last_7.last]
        Hash[:city, city, :province, province, :total, last_day, :nuevas, last_day - first_day].to_objectable
      end
    end

    def sort
      @contents = @contents.sort_by {|data| -data[:nuevas]}
    end

    def format
      msg = []

      top_five = @contents[2..].take(7).map {|record| "#{record.city}, #{record.province} #{fmt(record.total)} (+#{fmt(record.nuevas)})"}
      msg << ["Cantones con más nuevos casos comparando desde hace siete días:", top_five]

      priority = @contents[0,2].map {|record| "#{record.city}, #{record.province} #{fmt(record.total)} (+#{fmt(record.nuevas)})"}
      msg << ["\nGuayaquil y Quito:", priority]

      msg.flatten.join("\n")
    end
  end
end
