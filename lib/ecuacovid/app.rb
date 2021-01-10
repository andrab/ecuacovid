require 'ecuacovid/table'

module Ecuacovid

  class App

    attr_accessor :client
    attr_accessor :view
    
    def initialize(options={})
      @client = options[:client]
      @data = {}
      @view = options[:view]
      @report = options[:reporter] || Table.new
      @viz = options[:viz]
    end

    def reports_available
      REPORTS.keys.map(&:to_s).sort
    end

    def reporting_ready(view)
      @view = view unless view.nil?
      load_data
      @view.data_loaded
    end

    def charting_ready(view)
      @view = view unless view.nil?
      @view.chart_ready
    end

    def entities_ready(view)
      @view = view
      load_data
      @view.data_loaded
    end

    def load_chart(which)
      options = CHARTS[which]
      load_data([options[:model]])
      report = @report.construct(@data[options[:model]], options)
      @view.display_chart(@viz.build_url(options[:kind], options.merge(report)))
    end

    def with_model_load_chart(which)
      options = CHARTS[which]
      report = @report.construct(@view.model, options)
      @view.display_chart(@viz.build_url(options[:kind], options.merge(report)))
    end

    def load_report(which)
      options = REPORTS[which]

      load_data([options[:model]])     
      summary = @report.wrap_up(options.merge(datum: @data[options[:model]]))
      @view.display_report(summary)
    end

    def entities(model, options={})
      load_model(model, filters: options[:filters])
      @view.display_report(@data[model])
    end

    CITY = {
      columns: [:provincia, :canton],
      target: ->(record) { "#{record.provincia}-#{record.canton}" }
    }

    PROVINCE = { columns: [:provincia], target: :provincia }

    DAILY   = {by: ->(record) {record.created_at.strftime("%d/%m/%Y")}}
    WEEKLY  = {by: ->(record) {record.created_at.strftime("%V").to_i}}
    MONTHLY = {by: ->(record) {record.created_at.strftime("%-m").to_i}}

    WEEKLY_FORMAT = ->(column) {"Semana #{column.to_s}"}
    MONTHLY_FORMAT = ->(column) { 
      [
        "Enero", "Febrero", "Marzo", "Abril",
        "Mayo", "Junio", "Julio", "Agosto",
        "Septiembre", "Octubre", "Noviembre",
        "Diciembre"
      ][(column % 12) - 1]
    }

    MONTHY_ABRV_FORMAT = ->(column) {
      column = column.class == String ? column.to_i : column

      MONTHLY_FORMAT.(column)[0...3]
    }

    REPORTS = {
      positives_cities_new_per_day: CITY.merge({ model: :positives, eval: :nuevas, keep: [:canton, :created_at]}).merge(DAILY),
      positives_cities_new_per_week: CITY.merge({ model: :positives, eval: :nuevas, rename: {created_at: :semana}, keep: [:provincia, :created_at]}).merge(WEEKLY),
      positives_cities_accumulated_per_week: CITY.merge({ model: :positives, reduce: Ecuacovid::Table::ACC, eval: :nuevas, rename: {created_at: :semana}, keep: [:provincia, :created_at]}).merge(WEEKLY),
      positives_cities_new_per_month: CITY.merge({ model: :mortalities, eval: :nuevas, rename: {created_at: :mes}, keep: [:provincia, :created_at]}).merge(MONTHLY),
      positives_cities_accumulated_per_month: CITY.merge({ model: :positives, reduce: Ecuacovid::Table::ACC, eval: :nuevas, rename: {created_at: :mes}, keep: [:provincia, :created_at]}).merge(MONTHLY),
      positives_cities_new_per_day_tabulated: CITY.merge({ model: :positives, eval: :nuevas, form: :tabular}).merge(DAILY),
      positives_cities_accumulated_per_day_tabulated: CITY.merge({ model: :positives, reduce: Ecuacovid::Table::ACC, eval: :nuevas, form: :tabular }).merge(DAILY),      
      positives_cities_new_per_week_tabulated: CITY.merge({ model: :positives, eval: :nuevas, form: :tabular, format: WEEKLY_FORMAT}).merge(WEEKLY),
      positives_cities_accumulated_per_week_tabulated: CITY.merge({ model: :positives, reduce: Ecuacovid::Table::ACC, eval: :nuevas, form: :tabular, format: WEEKLY_FORMAT}).merge(WEEKLY),
      positives_cities_new_per_month_tabulated: CITY.merge({ model: :positives, eval: :nuevas, form: :tabular, format: MONTHLY_FORMAT}).merge(MONTHLY),
      positives_cities_accumulated_per_month_tabulated: CITY.merge({ model: :positives, reduce: Ecuacovid::Table::ACC, eval: :nuevas, form: :tabular, format: MONTHLY_FORMAT}).merge(MONTHLY),
      positives_provinces_new_per_day: PROVINCE.merge({ model: :positives, eval: :nuevas, keep: [:provincia, :created_at]}).merge(DAILY),
      positives_provinces_accumulated_per_day: PROVINCE.merge({ model: :positives, reduce: Ecuacovid::Table::ACC, eval: :nuevas, new: :total, keep: [:provincia, :created_at]}).merge(DAILY),
      positives_provinces_new_per_week: PROVINCE.merge({ model: :positives, eval: :nuevas, rename: {created_at: :semana}, keep: [:provincia, :created_at]}).merge(WEEKLY),
      positives_provinces_accumulated_per_week: PROVINCE.merge({ model: :positives, reduce: Ecuacovid::Table::ACC, eval: :nuevas, rename: {created_at: :semana}, new: :total, keep: [:provincia, :created_at]}).merge(WEEKLY),
      positives_provinces_new_per_month: PROVINCE.merge({ model: :positives, eval: :nuevas, rename: {created_at: :mes}, keep: [:provincia, :created_at]}).merge(MONTHLY),
      positives_provinces_accumulated_per_month: PROVINCE.merge({ model: :positives, reduce: Ecuacovid::Table::ACC, eval: :nuevas, rename: {created_at: :mes}, new: :total, keep: [:provincia, :created_at]}).merge(MONTHLY),
      positives_provinces_new_per_day_tabulated: PROVINCE.merge({ model: :positives, eval: :nuevas, form: :tabular }).merge(DAILY),
      positives_provinces_accumulated_per_day_tabulated: PROVINCE.merge({ model: :positives, reduce: Ecuacovid::Table::ACC, eval: :nuevas, form: :tabular }).merge(DAILY),
      positives_provinces_new_per_week_tabulated: PROVINCE.merge({ model: :positives, eval: :nuevas, form: :tabular, format: WEEKLY_FORMAT}).merge(WEEKLY),
      positives_provinces_accumulated_per_week_tabulated: PROVINCE.merge({ model: :positives, reduce: Ecuacovid::Table::ACC, eval: :nuevas, form: :tabular, format: WEEKLY_FORMAT}).merge(WEEKLY),
      positives_provinces_new_per_month_tabulated: PROVINCE.merge({ model: :positives, eval: :nuevas, form: :tabular, format: MONTHLY_FORMAT}).merge(MONTHLY),
      positives_provinces_accumulated_per_month_tabulated: PROVINCE.merge({ model: :positives, reduce: Ecuacovid::Table::ACC, eval: :nuevas, form: :tabular, format: MONTHLY_FORMAT}).merge(MONTHLY),
      deaths_provinces_new_per_week: PROVINCE.merge({ model: :deaths, eval: :nuevas, rename: {created_at: :semana}, keep: [:provincia, :created_at]}).merge(WEEKLY),
      deaths_provinces_accumulated_per_week: PROVINCE.merge({ model: :deaths, reduce: Ecuacovid::Table::ACC, eval: :nuevas, rename: {created_at: :semana}, new: :total, keep: [:provincia, :created_at]}).merge(WEEKLY),   
      deaths_provinces_new_per_month: PROVINCE.merge({ model: :deaths, eval: :nuevas, rename: {created_at: :mes}, keep: [:provincia, :created_at]}).merge(MONTHLY),
      deaths_provinces_accumulated_per_month: PROVINCE.merge({ model: :deaths, reduce: Ecuacovid::Table::ACC, eval: :nuevas, rename: {created_at: :mes}, new: :total, keep: [:provincia, :created_at]}).merge(MONTHLY),
      deaths_provinces_new_per_day_tabulated: PROVINCE.merge({ model: :deaths, eval: :nuevas, form: :tabular }).merge(DAILY),
      deaths_provinces_accumulated_per_day_tabulated: PROVINCE.merge({ model: :deaths, reduce: Ecuacovid::Table::ACC, eval: :nuevas, form: :tabular }).merge(DAILY),
      deaths_provinces_new_per_week_tabulated: PROVINCE.merge({ model: :deaths, eval: :nuevas, form: :tabular, format: WEEKLY_FORMAT}).merge(WEEKLY),
      deaths_provinces_accumulated_per_week_tabulated: PROVINCE.merge({ model: :deaths, reduce: Ecuacovid::Table::ACC, eval: :nuevas, form: :tabular, format: WEEKLY_FORMAT}).merge(WEEKLY),
      deaths_provinces_new_per_month_tabulated: PROVINCE.merge({ model: :deaths, eval: :nuevas, form: :tabular, format: MONTHLY_FORMAT}).merge(MONTHLY),
      deaths_provinces_accumulated_per_month_tabulated: PROVINCE.merge({ model: :deaths, reduce: Ecuacovid::Table::ACC, eval: :nuevas, form: :tabular, format: MONTHLY_FORMAT}).merge(MONTHLY),
      mortalities_cities_new_per_day_tabulated: CITY.merge({ model: :mortalities, eval: :total, form: :tabular }).merge(DAILY),
      mortalities_cities_accumulated_per_day_tabulated: CITY.merge({ model: :mortalities, reduce: Ecuacovid::Table::ACC, eval: :total, form: :tabular }).merge(DAILY),
      mortalities_cities_new_per_week_tabulated: CITY.merge({ model: :mortalities, eval: :total, form: :tabular, format: WEEKLY_FORMAT}).merge(WEEKLY),
      mortalities_cities_accumulated_per_week_tabulated: CITY.merge({ model: :mortalities, reduce: Ecuacovid::Table::ACC, eval: :total, form: :tabular, format: WEEKLY_FORMAT}).merge(WEEKLY),
      mortalities_cities_new_per_month_tabulated: CITY.merge({ model: :mortalities, eval: :total, form: :tabular, format: MONTHLY_FORMAT}).merge(MONTHLY),
      mortalities_cities_accumulated_per_month_tabulated: CITY.merge({ model: :mortalities, reduce: Ecuacovid::Table::ACC, eval: :total, form: :tabular, format: MONTHLY_FORMAT}).merge(MONTHLY),
      mortalities_provinces_new_per_day: PROVINCE.merge({ model: :mortalities, eval: :total, keep: [:provincia, :created_at]}).merge(DAILY),
      mortalities_provinces_accumulated_per_day: PROVINCE.merge({ model: :mortalities, reduce: Ecuacovid::Table::ACC, eval: :total, new: :acumuladas, keep: [:provincia, :created_at]}).merge(DAILY),
      mortalities_provinces_new_per_week: PROVINCE.merge({ model: :mortalities, eval: :total, rename: {created_at: :semana}, keep: [:provincia, :created_at]}).merge(WEEKLY),
      mortalities_provinces_accumulated_per_week: PROVINCE.merge({ model: :mortalities, reduce: Ecuacovid::Table::ACC, eval: :total, rename: {created_at: :semana}, new: :acumuladas, keep: [:provincia, :created_at]}).merge(WEEKLY),
      mortalities_provinces_new_per_month: PROVINCE.merge({ model: :mortalities, eval: :total, rename: {created_at: :mes}, keep: [:provincia, :created_at]}).merge(MONTHLY),
      mortalities_provinces_accumulated_per_month: PROVINCE.merge({ model: :mortalities, reduce: Ecuacovid::Table::ACC, eval: :total, rename: {created_at: :mes}, new: :acumuladas, keep: [:provincia, :created_at]}).merge(MONTHLY),
      mortalities_provinces_new_per_day_tabulated: PROVINCE.merge({ model: :mortalities, eval: :total, form: :tabular }).merge(DAILY),
      mortalities_provinces_accumulated_per_day_tabulated: PROVINCE.merge({ model: :mortalities, reduce: Ecuacovid::Table::ACC, eval: :total, form: :tabular }).merge(DAILY),
      mortalities_provinces_new_per_week_tabulated: PROVINCE.merge({ model: :mortalities, eval: :total, form: :tabular, format: WEEKLY_FORMAT}).merge(WEEKLY),
      mortalities_provinces_accumulated_per_week_tabulated: PROVINCE.merge({ model: :mortalities, reduce: Ecuacovid::Table::ACC, eval: :total, form: :tabular, format: WEEKLY_FORMAT}).merge(WEEKLY),
      mortalities_provinces_new_per_month_tabulated: PROVINCE.merge({ model: :mortalities, eval: :total, form: :tabular, format: MONTHLY_FORMAT}).merge(MONTHLY),
      mortalities_provinces_accumulated_per_month_tabulated: PROVINCE.merge({ model: :mortalities, reduce: Ecuacovid::Table::ACC, eval: :total, form: :tabular, format: MONTHLY_FORMAT}).merge(MONTHLY),
    }

    private
    def load_data(models = [])
      (!models.empty? && models || [:positives, :deaths, :mortalities]).each do |model|
        load_model(model)
      end
    end

    def load_model(model, options={})
      @data[model] ||= @client.send(model, filters: options[:filters])
    end

  end

end
