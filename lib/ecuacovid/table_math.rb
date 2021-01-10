require 'date'

module Ecuacovid

  module TableMath

    DEFAULT_DATE = ->(value) { value.created_at.strftime("%d/%m/%Y") }
    UNIT = ->(_) { 1 }

    class << self
      def gen_calculation(multiply, &fn)
        lambda do |acc, data|
          result = (acc * multiply)
          return result if data.nil?
          result + fn.call(data)
        end
      end
    end

    COUNT = gen_calculation(0) {|data| data.reduce(0) { |sum, value| sum + value } }
    ACC = gen_calculation(1) { |data| data.reduce(0) { |sum, value| sum + value } }
    ONE = gen_calculation(1) {|data| puts data.inspect}
    
    def group(datum, by)
      fn = fn!(by)
  
      {}.tap do |groups|
        datum.each do |data|
          fetch(groups, fn.(data), []) {|c| c << data}
        end
      end
    end

    def split_into_subtables(groups, target)
      return {table: groups} if not target

      {}.tap do |subtables|
        groups.each_pair do |group, dataset|
          group(dataset, target).each_pair do |subtable_name, rows|
            fetch(subtables, subtable_name, {}) {|c| c[group] = rows}
          end
        end
      end
    end

    def sort(subtable_names, group_names, tables)
      subtable_names.map do |name|
        groups = tables[name]
        group_names.map {|name| groups[name] || []}
      end
    end

    def eval(datasets, column)
      values = fn!(column) || UNIT

      datasets.map do |subsets|
        subsets.map do |data|
          data.nil? ? [] : (data.map &values)
        end
      end
    end

    def rest(datasets, options)
      columns = options[:columns] || []
      keep = options[:keep] || []
      keys = columns + keep

      values = ->(value) {
        if value.nil?
          return {}
        end

        value = value.slice(*keys)

        value.reduce({}) do |d, dict|
          begin
            val = options[:by].(Hash[*dict].to_objectable)
            d[dict[0]] = val
          rescue
            d[dict[0]] = dict[1]
          end
          d
        end
      }

      datasets.map do |subsets|
        subsets.map do |data|
          case
            when data.nil? || data.empty?
              []
            else
              values.(data.last)
          end
        end
      end
    end

    def reduce(datasets, reducer)
      values = fn!(reducer) || COUNT

      datasets.map do |subsets|
        acc = 0
        subsets.map do |data|
          acc = values.(acc, data)
        end
      end
    end
   
    def dates(groups, options = {})
      keys = groups.keys.sort {|a,b| DateTime.parse(a) <=> DateTime.parse(b)}
       
      date = DateTime.parse(keys.first)
      end_date = DateTime.parse(keys.last)

      [].tap do |labels|
        while date <= end_date
          labels << date.strftime("%d/%m/%Y")
          date = date.next_day(1)
        end
      end
    end

    def max(reduced)
      reduced.map {|set| set.max }.max
    end

    def min(reduced)
      reduced.map {|set| set.min}.min
    end

    def percentages(max, values)
      values.map do |subset|
        subset.map {|total| total * 100.0 / max}
      end
    end

    def tags(groups, options)
      begin
        dates(groups, options)
      rescue
        groups.keys.sort
      end
    end

    def construct(datum, options={})
      grouped        = group(datum, options[:by] || DEFAULT_DATE)
      subtables      = split_into_subtables(grouped, options[:target])

      dates          = tags(grouped, options)
      subtable_names = subtables.keys.sort 
      sorted         = sort(subtable_names, dates, subtables)
      values         = eval(sorted, options[:eval])
      rest           = rest(sorted, options)
      reduced        = reduce(values, options[:reduce])
      max            = max(reduced)
      min            = min(reduced)

      percentages    = percentages(max, reduced)

      y_range = (0..max)

      {:rest => rest,
       :column_names => dates,
       :column_count => (0...(dates.count)),
       :y_range => y_range,
       :y_labels => (options[:y_labels] ? nil : [0, max / 2, max]),
       :data => (options[:percent] ? percentages : reduced),
       :subtable_names => options[:target] ? subtable_names : nil}
    end
  
    private
    def fn!(expression)
      return ->(value) { value[expression] } if expression.kind_of?(Symbol)
      expression
    end
  
    def fetch hash, key, default
      collection = hash.fetch(key, default)
      yield(collection) 
      hash.store(key, collection)
    end
    
  end

end
