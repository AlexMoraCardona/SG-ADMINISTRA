class Level < ApplicationRecord

    def name_state(state)
        if state == 0 ; 'Activo'
        elsif state == 1 ; 'Inactivo'
        end 
    end  

    def name_level_user(level_user)
        if level_user == 1 ; 'Nuevo'
        elsif level_user == 2 ; 'Antiguo'
        elsif level_user == 3 ; 'Administrador'
        end 
    end  

    def name_restriction(res)
        if res == 0 ; 'No'
        elsif res == 1 ; 'Si'
        end 
    end  

end
