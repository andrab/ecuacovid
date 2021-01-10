unless ENV["TRAVIS"]
  require "simplecov"
  
  SimpleCov.start do
    add_group "tests", "spec"
  end
end

MONTH = lambda do |column| 
  [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ][column - 1]
end

