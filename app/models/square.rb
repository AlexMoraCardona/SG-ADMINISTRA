class Square < ApplicationRecord

    def name_state(state)
        if state == 0 ; 'Disponible'
        elsif state == 1 ; 'No disponible'
        end 
    end  

end
