class PlacesController < ApplicationController
    def index
        if  Current.user && Current.user.level_id == 3
            @places = Place.all 
        else
             redirect_to new_session_path, alert: t('common.not_logged_in')      
         end           
    end    

    def new
      @place = Place.new  
    end    

    def create
        @place = Place.new(place_params)

        if @place.save then
            redirect_to places_path, notice: t('.created') 
        else
            render :new, places: :unprocessable_entity
        end    
    end    
 
    def edit
        @place = Place.find(params[:id])
    end
    
    def update
        @place = Place.find(params[:id])
        if @place.update(place_params)
            redirect_to places_path, notice: 'Turno actualizado correctamente'
        else
            render :edit, status: :unprocessable_entity
        end         
    end    

    def destroy
        @place = Place.find(params[:id])
        @place.destroy
        redirect_to places_path, notice: 'Turno borrado correctamente', place: :see_other
    end    

    private

    def place_params
        params.require(:place).permit(:state, :place_reserva)
    end 

end    

