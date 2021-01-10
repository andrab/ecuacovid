require 'ecuacovid/data/client'
require 'ecuacovid/data/handshake'
require 'ecuacovid/data/connection'

module EcuacovidData
    
  class Positives
    attr_accessor :years, :filters
  
    def model
      :positives
    end
  
    def select(record)
      equality = @filters.select {|cond| cond[0] == :created_at && cond[1] == :eq}
      equality.all? {|(field, op, value)| record.send(field) == value}
    end
  end
  
  class Query
    attr_reader :model
  
    def initialize(filters)
      @filters = filters
    end
  
    def positives
      @model = :positives
      @years = @filters.select {|(field, op, value)| field == :year && op == :eq}

      @includes = @filters.select {|(field, op, value)| op == :in && field == :year}
  
      if @years.empty?
        if @includes.empty?
          @years = [2020, 2021]
        else
          _field, _op, years = @includes.find {|(field, _in, value)| field == :year}
          @years = years
        end
      else
        _field, _op, year = @years.first
        @years = [year]
      end
        
      m = Positives.new
      m.years = @years
      m.filters = @filters
      m
    end
  
    class << self
      def where(keys={}, op = :eq)
        klass = Builder.new
        klass.filters = klass.filters + keys.entries.map do |(k, v)|
          [k, op, v]            
        end if keys.class == Hash
    
        klass
      end
    end
  
    class Builder
      attr_writer :filters, :model
  
      def filters
        (@filters ||= [])
      end
  
      def compile
        Query.new(filters).send(@model)
      end
    end
  
  end
  
end
