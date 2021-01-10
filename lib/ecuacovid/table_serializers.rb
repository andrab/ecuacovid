module Ecuacovid

  module TableSerializers

    Csv = ->(columns, rows) {
      [columns.join(","), rows.map do |rows|
        rows.map do |row|
          row.join(",")
        end.join("\n")
      end.flatten].join("\n")
    }

    Nu = ->(columns, rows) {
        rows.map do |value| 
          value.map do |row|
            Hash[columns.map(&:to_s).zip(row)]
          end
        end
    }

  end

end
