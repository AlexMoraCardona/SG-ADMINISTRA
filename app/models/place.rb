class Place < ApplicationRecord
    def name_state(state)
        if state == 0 ; 'Si'
        elsif state == 1 ; 'No'
        end 
    end      
end
