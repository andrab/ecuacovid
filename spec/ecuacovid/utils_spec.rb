require 'ecuacovid/utils/datos_reajustador'
require 'ecuacovid/utils/matematicas'

describe Ecuacovid::Utils::DatosReajustador do
  it "Rellena en fracciones iguales" do
    original = [10850, 11183, 11183, 11183, 11183, 11183, 15728]
    datos    = [10850, 11183,     1,     1,     1,     1, 15728]
    esperado = [10850, 11183, 12092, 13001, 13910, 14819, 15728]
    expect(datos.reajustar).to eql(esperado)
 
    original = [18863, 20937, 22981, 22981, 20483, 21361, 19881, 20134, 20622, 20572]
    datos    = [18863, 19881,     1,     1,     1,     1,     1,     1,     1, 20572]
    esperado = [18863, 19881, 19967, 20053, 20139, 20225, 20311, 20397, 20483, 20572]
    expect(datos.reajustar).to eql(esperado)

    original = [7391,  7502, 7502, 7502, 7502, 7502, 10200]
    datos    = [7391,  7502,    1,    1,    1,    1, 10200]
    esperado = [7391,  7502, 8041, 8580, 9119, 9658, 10200]
    expect(datos.reajustar).to eql(esperado)

    original = [11695, 13053, 14192, 14192, 12411, 12577, 11532, 11577, 11705, 11876]
    datos    = [11695, 11705,     1,     1,     1,     1,     1,     1,     1, 11876]
    esperado = [11695, 11705, 11726, 11747, 11768, 11789, 11810, 11831, 11852, 11876]
    expect(datos.reajustar).to eql(esperado)
    
    original = [5502, 5565, 5565, 5565, 5565, 5565, 7400]
    datos    = [5502, 5565,    1,    1,    1,    1, 7400]
    esperado = [5502, 5565, 5932, 6299, 6666, 7033, 7400]
    expect(datos.reajustar).to eql(esperado)

    original = [8074,  8324,  9291,  9954,  9954,  8804,  8881,  8051,  8068,  8096, 8226]
    datos    = [8074,     1,     1,     1,     1,     1,     1,     1,     1,     1, 8226]
    esperado = [8074,  8089,  8104,  8119,  8134,  8149,  8164,  8179,  8194,  8209, 8226]
    expect(datos.reajustar).to eql(esperado)
  end

  it "Encuentra la mediana" do
    expect([12].mediana).to be_within(0.1).of(12.0)
    expect([12, 3, 5].mediana).to be_within(0.1).of(5.0)
    expect([3, 13, 7, 5, 21, 23, 23, 40, 23, 14, 12, 56, 23, 29].mediana).to be_within(0.1).of(22.0)
  end
end