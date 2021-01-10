require 'ecuacovid/utils/objectable'

class StubData
  class << self
    def sample_cases
      [
        {id:  1, provincia:    "Manabí", total:     0, nuevas:   0, created_at: DateTime.new(2020,  1,  1)},
        {id:  2, provincia: "Pichincha", total:     0, nuevas:   0, created_at: DateTime.new(2020,  1,  1)},
        {id:  3, provincia:    "Guayas", total:     0, nuevas:   0, created_at: DateTime.new(2020,  1,  1)},
        {id:  4, provincia:    "Manabí", total:  9498, nuevas:  58, created_at: DateTime.new(2020,  9, 22)},
        {id:  5, provincia: "Pichincha", total: 40775, nuevas: 845, created_at: DateTime.new(2020, 10,  1)},
        {id:  6, provincia:    "Manabí", total:  3354, nuevas:  19, created_at: DateTime.new(2020,  6, 15)},
        {id:  7, provincia:    "Manabí", total:    56, nuevas:   2, created_at: DateTime.new(2020,  4,  1)},
        {id:  8, provincia:    "Guayas", total:  7502, nuevas:   0, created_at: DateTime.new(2020,  4, 24)},
        {id:  9, provincia: "Pichincha", total: 21619, nuevas: 633, created_at: DateTime.new(2020,  8, 19)},
        {id: 10, provincia:    "Guayas", total: 11577, nuevas:  45, created_at: DateTime.new(2020,  5,  9)},
        {id: 11, provincia: "Pichincha", total:  6620, nuevas: 164, created_at: DateTime.new(2020,  6, 25)},
        {id: 12, provincia: "Pichincha", total:  3540, nuevas: 135, created_at: DateTime.new(2020,  5, 25)},
        {id: 13, provincia: "Pichincha", total: 14919, nuevas: 106, created_at: DateTime.new(2020,  8,  1)}
      ].map(&:to_objectable)
    end
  end
end