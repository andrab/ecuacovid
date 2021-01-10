require 'ecuacovid/table_math'
require 'ecuacovid/table_serializers'

module Ecuacovid

  class Table

    include TableMath

    ELEMENTS = [:headers, :rows]

    def initialize(options={})
      @serializer = options[:serializer]
    end

    def wrap_up(options={})
      datum = options.delete(:datum)
      summary = options[:report] || construct(datum, options)

      summary[:headers] = options.delete(:columns).dup if tabulated?(options)
      summary[:column_names] = summary[:column_names].map {|label| options[:format].(label)} if options[:format]

      columns, table = ELEMENTS.map {|p| self.send(p, options.merge(summary))}

      serializer.call(columns, table)
    end

    def serializer
      @serializer || Ecuacovid::TableSerializers::Csv
    end

    def headers(options={})
      cols  = rename(options[:headers], options)
      cols << rename(options[:column_names], options) unless default?(options)
      cols << rename(options[:keep], options) if default?(options)
      cols << rename(options[:new] || options[:eval], options) unless tabulated?(options)
      
      cols.flatten.uniq
    end

    def rows(options={})
      case
        when tabulated?(options)
          tabulated_rows(options)
        when default?(options)
          default_rows(options)
      end
    end

    private

    def tabulated?(options={form: :default})
      options[:form] == :tabular
    end

    def default?(options={form: :default})
      !tabulated?(options)
    end

    def rename(names, replacements)
      return [] if names.nil?

      new_names = replacements[:rename] || {}
      new_names.empty? ? names : (!names.is_a?(Array) ? [names] : names).map {|name| new_names[name] || name}.compact
    end

    def tabulated_rows(options)
      headers = options[:headers] || []

      options[:data].map.with_index do |subsets, idx|
        some = options[:rest][idx].filter {|v| !v.empty?}.find {|r| r.keys.any? {|l| headers.include?(l)}}
        [(headers.empty? ? [] : some.slice(*headers).values) + subsets]
      end
    end

    def default_rows(options)
      options[:data].map.with_index do |subsets, y_idx|
        subsets.map.with_index do |data, x_idx|
          value = options[:rest][y_idx][x_idx]
          !value.empty? ? value.slice(*options[:keep]).values + [data] : nil
        end.compact
      end
    end

  end

end
