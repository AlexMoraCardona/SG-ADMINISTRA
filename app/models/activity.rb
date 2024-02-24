class Activity < ApplicationRecord
    belongs_to :calendar
    belongs_to :user
    belongs_to :place
    belongs_to :square


    def label_state(dato)
        if dato == 0 ; 'Libre'
        elsif dato == 1 ; 'Reservada'
        elsif dato == 2 ; 'No disponible'
        elsif dato == 3 ; 'Vencido'
        end 
    end 
    
    
    def self.crear_actividades(adm_calendar)
        @places = Place.where("state = ?", 0)
        @squares = Square.where("state = ?", 0)
        @calendars = Calendar.where("year = ? and day_vigente = ?", adm_calendar.year, 0)
        
        @calendars.each do |calendar|
            @squares.each do |square|
                @places.each do |place|
                    @activity = Activity.new
                    @activity.state = 0
                    @activity.calendar_id = calendar.id
                    @activity.square_id = square.id 
                    @activity.place_id = place.id
                    @activity.user_id = 3
                    @activity.save
                end    
            end
        end    

    end    

    def self.validaciones(activity, activities)
        val = 0
        contador = 0
        #la fecha de la actividad que se va a reservar
        diares = activity.calendar.day
        mesres = activity.calendar.month
        anores = activity.calendar.year
        fecres = (diares.to_s + "/" + mesres.to_s + "/" + anores.to_s).to_s
        date_fecres = fecres.to_date  
        semana_res = (date_fecres.strftime("%U")).to_i

        #control de numero de actividades por semana
        activities.each do |act|
            dia = act.calendar.day
            mes = act.calendar.month
            ano = act.calendar.year
            fec = (dia.to_s + "/" + mes.to_s + "/" + ano.to_s).to_s
            date_fec = fec.to_date  
            semana_act = (date_fec.strftime("%U")).to_i
            if semana_res  == semana_act then
                contador = contador + 1
            end    
        end
        #control actividades vencidas
        dia = activity.calendar.day
        mes = activity.calendar.month
        ano = activity.calendar.year
        fec = (dia.to_s + "/" + mes.to_s + "/" + ano.to_s).to_s
        date_act = fec.to_date  
        date_hoy = (Time.now.strftime("%d-%m-%Y")).to_date

        if date_act >= date_hoy then #actividades que ya vencieron
            if contador >= 2 then #mas de dos actividades
                   val = 1
            else
                if activity.state == 0 then # estado de la actividad debe ser disponible
                    if Current.user.level.restriction == 1 && Current.user.level.restriction_count > 0  #validar la restricciones del usuario
                        dia_calen = activity.calendar.day
                        mes_calen = activity.calendar.month
                        ano_calen = activity.calendar.year
                        fecha_act = (dia_calen.to_s + "/" + mes_calen.to_s + "/" + ano_calen.to_s).to_s
                        date_fecha_act = fecha_act.to_date  
                        date_fecha_hoy = (Time.now.strftime("%d-%m-%Y")).to_date 
                        nrodias = (date_fecha_act - date_fecha_hoy).to_i
                        rest = Current.user.level.restriction_count
                        if nrodias > rest #actividad no disponible para reservar
                            val = 4 
                        else
                            val = 10
                        end    
                    else 
                        val = 10   
                    end    
                else
                    val = 3 
                end 
            end   
        else
            val = 2 
        end    


    end    
end
