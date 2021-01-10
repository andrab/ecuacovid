require 'ecuacovid/table'

require_relative './stub_data'

describe Ecuacovid::Table do

  let(:records) { StubData.sample_cases }

  let(:table) {
    options = {
      by: ->(record) { record.created_at.strftime("%-m").to_i },
      target: :provincia,
      eval: :nuevas,

      columns: [:provincia]
    }

    options = subject.construct(records, options)
    options.merge column_names: options[:column_names].map {|d| MONTH.(d)}
  }

  let(:tabular_table) {
    table.merge(form: :tabular)
  }

  context "Tabulated" do
    it "includes original headers" do
      expect(subject.headers(tabular_table)).to eq(%w{Jan Apr May Jun Aug Sep Oct})
    end

    it "adds more headers" do
      options = tabular_table.merge headers: [:city, :province]
      expect(subject.headers(options)).to eq([:city, :province, "Jan", "Apr", "May", "Jun", "Aug", "Sep", "Oct"])
    end

    it "renames headers" do
      options = tabular_table.merge rename: {"Apr" => "Abril"}
      expect(subject.headers(options)).to eq(%w{Jan Abril May Jun Aug Sep Oct})
    end

    it "compiles rows" do
      expected = [
        [[0, 0,  45,   0,   0,  0,   0]],
        [[0, 2,   0,  19,   0, 58,   0]],
        [[0, 0, 135, 164, 739,  0, 845]]
      ]

      expect(subject.rows(tabular_table)).to eq(expected)
    end

    it "compiles rows with additional header column value wanted" do
      expected = [
        [[   "Guayas", 0, 0,  45,   0,   0,   0,   0]],
        [[   "Manabí", 0, 2,   0,  19,   0,  58,   0]],
        [["Pichincha", 0, 0, 135, 164, 739,   0, 845]]
      ]

      options = tabular_table.merge headers: [:provincia]
      expect(subject.rows(options)).to eq(expected)
    end

    it "formats" do
      expected = "provincia,Jan,Apr,May,Jun,Aug,Sep,Oct\n"\
                 "Guayas,0,0,45,0,0,0,0\n"\
                 "Manabí,0,2,0,19,0,58,0\n"\
                 "Pichincha,0,0,135,164,739,0,845"
    
      options = tabular_table.merge report: tabular_table, columns: [:provincia] 
      expect(subject.wrap_up(options)).to eq(expected)
    end
  end

  context "Default" do
    it "ignores original headers" do
      expect(subject.headers(table)).to eq([])
    end

    it "compiles header columns" do
      expect(subject.headers(table.merge({headers: [:city, :province]}))).to eq([:city, :province])
      expect(subject.headers(table.merge({keep: [:Column3]}))).to eq([:Column3])
      expect(subject.headers(table.merge({headers: [:ciudad], rename: {ciudad: :city}}))).to eq([:city])
      expect(subject.headers(table.merge({headers: [:ciudad, :pais], rename: {pais: :country}}))).to eq([:ciudad, :country])
    end

    it "compiles rows" do
      expected = [
          [0, 0, 45].map {|value| ["Guayas", value] },
          [0, 2, 19, 58].map {|value| ["Manabí", value] },
          [0, 135, 164, 739, 845].map {|value| ["Pichincha", value] }
      ]

      rows = subject.rows(table.merge({keep: [:provincia]}))
      expect(rows).to eq(expected)
    end
  
    it "formats" do
      expected = [
        ["province,total_per_month"],
        [0, 0, 45].map {|value| "Guayas,#{value}" }.join("\n"),
        [0, 2, 19, 58].map {|value| "Manabí,#{value}" }.join("\n"),
        [0, 135, 164, 739, 845].map {|value| "Pichincha,#{value}" }.join("\n")
      ].join("\n")

      options = table.merge({
        headers: [:provincia, :total_per_month],
        keep: [:provincia],
        rename: {provincia: :province},

        report: table
      })

      expect(subject.wrap_up(options)).to eq(expected)
    end
  end
  
end