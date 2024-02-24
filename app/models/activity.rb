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

end
