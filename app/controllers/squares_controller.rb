class SquaresController < ApplicationController
    def index
        if  Current.user && Current.user.level_id == 3
            @squares = Square.all 
        else
             redirect_to new_session_path, alert: t('common.not_logged_in')      
         end           
    end    

    def new
      @square = Square.new  
    end    

    def create
        @square = Square.new(square_params)

        if @square.save then
            redirect_to squares_path, notice: t('.created') 
        else
            render :new, squares: :unprocessable_entity
        end    
    end    
 
    def edit
        @square = Square.find(params[:id])
    end
    
    def update
        @square = Square.find(params[:id])
        if @square.update(square_params)
            redirect_to squares_path, notice: 'Cancha actualizada correctamente'
        else
            render :edit, status: :unprocessable_entity
        end         
    end    

    def destroy
        @square = Square.find(params[:id])
        @square.destroy
        redirect_to squares_path, notice: 'Cancha borrada correctamente', square: :see_other
    end    

    private

    def square_params
        params.require(:square).permit(:state, :name, :address)
    end 

end    

