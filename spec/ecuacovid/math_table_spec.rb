require 'ecuacovid/table'

require_relative './stub_data'

describe Ecuacovid::Table do
  
  let (:records) { StubData.sample_cases }
  let (:guayas_province_records) { records.filter {|p| p.provincia == "Guayas"} }
  let (:guayas_and_pichincha_records) { records.reject {|p| p.provincia == "Manabí"} }

  it "groups by date" do
    months = subject.group(records, ->(r) { r.created_at.strftime("%b") })
    expect(months.size).to be(7)

    expect(months["Jan"].map(&:id)).to eq([1, 2, 3])
    expect(months["May"].map(&:id)).to eq([10, 12])
    expect(months["Apr"].map(&:id)).to eq([7, 8])
    expect(months["Aug"].map(&:id)).to eq([9, 13])
    expect(months["Jun"].map(&:id)).to eq([6, 11])
    expect(months["Sep"].map(&:id)).to eq([4])
    expect(months["Oct"].map(&:id)).to eq([5])
  end

  it "summarizes value counts per month" do
    options = {
      by: ->(record) { record.created_at.strftime("%-m").to_i },
      eval: :nuevas
    }

    per_month = subject.construct(records, options)
    
    expect(per_month[:column_count]).to eq(0...7)
    expect(per_month[:y_range]).to eq(0..845)
    expect(per_month[:column_names].map {|d| MONTH.(d)}).to eq(%w{Jan Apr May Jun Aug Sep Oct})
    expect(per_month[:data]).to eq([[0, 2, 180, 183, 739, 58, 845]])
  end

  it "summarizes value counts with accumulation per month" do
    options = {
      by: ->(record) { record.created_at.strftime("%-m").to_i },
      reduce: Ecuacovid::Table::ACC,
      eval: :total
    }

    per_month_acc = subject.construct(guayas_province_records, options)

    expect(per_month_acc[:y_range]).to eq(0..19079)
    expect(per_month_acc[:column_count]).to eq(0...3)
    expect(per_month_acc[:column_names].map {|d| MONTH.(d)}).to eq(%w{Jan Apr May})
    expect(per_month_acc[:data]).to eq([[0, 7502, 19079]])
  end

  it "summarizes value counts accumulated per month with targeted column name subtables" do
    options = {
      by: ->(record) { record.created_at.strftime("%-m").to_i },
      target: :provincia,
      reduce: Ecuacovid::Table::ACC,
      eval: :nuevas
    }

    provinces_per_month_acc = subject.construct(guayas_and_pichincha_records, options)

    expect(provinces_per_month_acc[:y_range]).to eq(0..1883)
    expect(provinces_per_month_acc[:column_count]).to eq(0...6)
    expect(provinces_per_month_acc[:column_names].map {|d| MONTH.(d)}).to eq(%w{Jan Apr May Jun Aug Oct})
    expect(provinces_per_month_acc[:data]).to eq([[0, 0, 45, 45, 45, 45], [0, 0, 135, 299, 1038, 1883]])
    expect(provinces_per_month_acc[:subtable_names]).to eq(%w{Guayas Pichincha})
  end

end
