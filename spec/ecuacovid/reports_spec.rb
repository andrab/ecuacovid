require 'ecuacovid/reports'

describe Ecuacovid::Reports do
  context "Tabulated" do
    let(:table) {
      {
        form: :tabular,
        x_labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Ago", "Sep", "Oct"],
        data: [
          [0, 0, 45, 0, 0, 0, 0, 0, 0, 0],
          [2, 0, 0, 0, 19, 0, 0, 0, 58, 0],
          [0, 0, 0, 135, 0, 164, 106, 633, 0, 845]
        ],
        rest: [
          [{provincia: "Guayas", ciudad: "Guayaquil"}],
          [{provincia: "Manabí", ciudad: "Manta"}],
          [{provincia: "Pichincha", ciudad: "Quito"}]
        ]
      }
    }

    it "includes original headers" do
      expect(subject.headers(table)).to eq("Jan,Feb,Mar,Apr,May,Jun,Jul,Ago,Sep,Oct")
    end

    it "adds more headers" do
      expect(subject.headers(table.merge({headers: [:city, :province]}))).to eq("city,province,Jan,Feb,Mar,Apr,May,Jun,Jul,Ago,Sep,Oct")
    end

    it "renames headers" do
      expect(subject.headers(table.merge({rename: {"Feb" => "Febrero"}}))).to eq("Jan,Febrero,Mar,Apr,May,Jun,Jul,Ago,Sep,Oct")
    end

    it "compiles rows" do
      expected = [
        [[0, 0, 45, 0, 0, 0, 0, 0, 0, 0]],
        [[2, 0, 0, 0, 19, 0, 0, 0, 58, 0]],
        [[0, 0, 0, 135, 0, 164, 106, 633, 0, 845]]
      ]

      rows = subject.rows(table)
      expect(rows).to eq(expected)
    end

    it "compiles rows with additional header column value wanted" do
      expected = [
        [["Guayas", 0, 0, 45, 0, 0, 0, 0, 0, 0, 0]],
        [["Manabí", 2, 0, 0, 0, 19, 0, 0, 0, 58, 0]],
        [["Pichincha", 0, 0, 0, 135, 0, 164, 106, 633, 0, 845]]
      ]

      rows = subject.rows(table.merge({headers: [:provincia]}))
      expect(rows).to eq(expected)
    end

    it "formats" do
      expected = "provincia,Jan,Feb,Mar,Apr,May,Jun,Jul,Ago,Sep,Oct\n"\
                 "Guayas,0,0,45,0,0,0,0,0,0,0\n"\
                 "Manabí,2,0,0,0,19,0,0,0,58,0\n"\
                 "Pichincha,0,0,0,135,0,164,106,633,0,845"

      text = subject.wrap_up(table.merge({headers: [:provincia]}))
      expect(text).to eq(expected)
    end
  end

  context "Default" do
    let(:table) {
      {
        x_labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Ago", "Sep", "Oct"],
        data: [
          [0, 0, 45, 0, 0, 0, 0, 0, 0, 0],
          [2, 0, 0, 0, 19, 0, 0, 0, 58, 0],
          [0, 0, 0, 135, 0, 164, 106, 633, 0, 845]
        ],
        rest: [
          (0...10).map { Hash[provincia: "Guayas", ciudad: "Guayaquil"] },
          (0...10).map { Hash[provincia: "Manabí", ciudad: "Manta"] },
          (0...10).map { Hash[provincia: "Pichincha", ciudad: "Quito"] }
        ]
      }
    }

    it "ignores original headers" do
      expect(subject.headers(table)).to eq("")
    end

    it "compiles header columns" do
      expect(subject.headers(table.merge({headers: [:city, :province]}))).to eq("city,province")
      expect(subject.headers(table.merge({keep: [:Column3]}))).to eq("Column3")
      expect(subject.headers(table.merge({headers: [:ciudad], rename: {ciudad: :city}}))).to eq("city")
      expect(subject.headers(table.merge({headers: [:ciudad, :pais], rename: {pais: :country}}))).to eq("ciudad,country")
    end

    it "compiles rows" do
      expected = [
          [0, 0, 45, 0, 0, 0, 0, 0, 0, 0].map {|value| ["Guayas", value] },
          [2, 0, 0, 0, 19, 0, 0, 0, 58, 0].map {|value| ["Manabí", value] },
          [0, 0, 0, 135, 0, 164, 106, 633, 0, 845].map {|value| ["Pichincha", value] }
      ]

      rows = subject.rows(table.merge({keep: [:provincia]}))
      expect(rows).to eq(expected)
    end
  
    it "formats" do
      expected = [
        ["total_per_month,city"],
        [0, 0, 45, 0, 0, 0, 0, 0, 0, 0].map {|value| "Guayaquil,#{value}" }.join("\n"),
        [2, 0, 0, 0, 19, 0, 0, 0, 58, 0].map {|value| "Manta,#{value}" }.join("\n"),
        [0, 0, 0, 135, 0, 164, 106, 633, 0, 845].map {|value| "Quito,#{value}" }.join("\n")
      ].join("\n")

      text = subject.wrap_up(table.merge({headers: [:total_per_month], keep: [:ciudad], rename: {ciudad: :city}}))
      expect(text).to eq(expected)
    end
  end
end