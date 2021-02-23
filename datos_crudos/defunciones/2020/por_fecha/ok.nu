echo $data |
            cases Guayas |
            meta-data |
            merge {
                echo $data |
                cases Guayas |
                roll-one-column |
                update Enero 0 |
                append $(echo $data | cases Guayas | reject provincia poblacion lat lng) | 
                math sum
            }