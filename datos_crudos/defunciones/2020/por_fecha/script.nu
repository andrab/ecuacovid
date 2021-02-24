def roll-one-column [] {
  roll column --cells-only --opposite |
  pivot _ value | st colle

  

#  update value $(= $it.value * -1)
  #pivot --header-row
}

def cases [province] {
  where provincia == $province
}

def record-columns [] {
    select provincia poblacion lat lng
}

def columns [] {
    reject provincia poblacion lat lng
}

def for [provinces] {
    let data = $(open lugar_provincias_por_mes_acumuladas.csv);

    echo $provinces | each {
        let subset = $(echo $data | cases $it);
        
        let saved_columns = $(echo $subset | record-columns);
        let use_columns = $(echo $subset | columns);

        #echo $saved_columns | merge { 
            do {
               # echo $use_columns |
               # each { = $it | roll-one-column } |
               # update Enero 0 |
                echo $use_columns | roll-one-column 
                #math sum
            }
       # }
    }
}



# | append $(open lugar_provincias_por_mes_acumuladas.csv | reject provincia poblacion lat lng | first) | math sum | pivot | update Column1 { = $it.Column1 * -1 }

#echo '-----COMPLETE' $(char newline) | str collect
#cases Guayas | reject provincia poblacion lat lng
#echo '-----END COMPLETE' $(char newline) | str collect

#echo '-----ONE COLUMN ROLLED' $(char newline) | str collect
#cases Guayas | roll-one-column 
#echo '-----END ONE COLUMN ROLLED' $(char newline) | str collect

for $(echo [ Guayas ] )
#cases Guayas | meta-data | merge { cases Guayas | roll-one-column | update Enero 0 | append $(cases Guayas | reject provincia poblacion lat lng) | math sum }