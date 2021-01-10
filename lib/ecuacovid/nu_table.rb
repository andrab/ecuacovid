require 'ecuacovid/table_serializers'

module Ecuacovid

  module Nu

    class NuTable
      ELEMENTS = [:headers, :rows]
  
      def initialize(options={})
        @options = options
      end
  
      def build(options={})
        @options = options
        wrap_up
      end
  
      def wrap_up(options={}, serializer = Ecuacovid::TableSerializers::Nu)
        @options = options if @options.empty?
        report = @options[:report] || construct(@options[:datum], @options)
        report[:column_names] = @options[:column_names].map {|label| @options[:format].(d)} if @options[:format]
        @options.merge!(report)
        headers, table = ELEMENTS.map {|p| self.send(p, @options)}
        
        serializer.call(headers, table)
      end
  
      def headers(options={})
        headers  = rename(options[:headers], options)
        headers << rename(options[:column_names], options) unless default?(options)
        headers << rename(options[:keep], options) if default?(options)
        headers << rename(options[:new] || options[:eval], options) unless tabulated?(options)
  
        headers.flatten.uniq
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
        new_names.empty? ? names : (!names.is_a?(Array) ? [names] : names).map {|name| new_names.fetch(name, name)}
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
  
end
