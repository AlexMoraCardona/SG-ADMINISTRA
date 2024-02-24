class ActivitiesController < ApplicationController
    def index

        if  Current.user && Current.user.level_id == 3
            @activities = Activity.all
         else
             redirect_to new_session_path, alert: t('common.not_logged_in')      
         end          
         
    end    

    def show
        @activity = Activity.find(params[:id])
        @calendar = Calendar.find(@activity.calendar_id) if @activity.present?
        #@activity_users = ActivityUser.where("activity_id = ?", @activity.id) if @activity.present? 

    end

    def new
      @activity = Activity.new  
    end    

    def create
        @activity = Activity.new(activity_params)

        if @activity.save then
            redirect_to detail_path(@activity.calendar_id), notice: t('.created') 
        else
            render :edit, status: :unprocessable_entity
        end    
    end    
 
    def edit
        @activity = Activity.find(params[:id])
    end
    
    def update 
        @activity = Activity.find(params[:id])
        if @activity.update(activity_params)
            redirect_to detail_path(@activity.calendar_id), notice: 'Actividad actualizada correctamente'
        else
            render :edit, activities: :unprocessable_entity
        end         
    end    

    def reser 
        @activity = Activity.find(params[:id])
        @activities = Activity.where("user_id = ? and state = ?",Current.user.id,1)

        val = Activity.validaciones(@activity, @activities)
        
        if val == 10 then 
            @activity.user_id = Current.user.id
            @activity.state = 1
            if @activity.save
                redirect_to home_path, notice: 'Actividad actualizada correctamente'
            else
                render :edit, activities: :unprocessable_entity
            end         
        else
            if val == 1 then 
                redirect_to home_path, alert: 'El máximo de reservaciones permitidas por semana son 2.'
            else    
                if val == 2 then 
                    redirect_to home_path, alert: 'No es posible hacer la reservación, la fecha esta vencida.'  
                else    
                    if val == 3 then 
                        redirect_to home_path, alert: 'Actividad no se encuentra disponible para reservar'
                    else    
                        if val == 4 then 
                            redirect_to home_path, alert: 'Actividad no se encuentra disponible para reservar'
                        else
                            if val == 0 then 
                                redirect_to home_path, alert: 'No se pudo reservar la actividad, por favor consulte con el Administrador'
                            end    
                        end        
                    end                    
                end        
            end    
        end
    end    

    def reser_anterior 
        @activity = Activity.find(params[:id])
        @activities = Activity.where("user_id = ? and state = ?",Current.user.id,1)

        val = Activity.validaciones(@activity,@activities).to_i
        if val == 10 then
        elsif val == 1 then 
        elsif val == 1 then 
        elsif val == 1 then 
        elsif val == 1 then 
        end    
        el    
        contador = 0
        #la fecha de la actividad que se va a reservar
        diares = @activity.calendar.day
        mesres = @activity.calendar.month
        anores = @activity.calendar.year
        fecres = (diares.to_s + "/" + mesres.to_s + "/" + anores.to_s).to_s
        date_fecres = fecres.to_date  
        semana_res = (date_fecres.strftime("%U")).to_i

        #control de numero de actividades por semana
        @activities.each do |act|
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
        dia = @activity.calendar.day
        mes = @activity.calendar.month
        ano = @activity.calendar.year
        fec = (dia.to_s + "/" + mes.to_s + "/" + ano.to_s).to_s
        date_act = fec.to_date  
        date_hoy = (Time.now.strftime("%d-%m-%Y")).to_date

        if date_act >= date_hoy then #actividades que ya vencieron
            if contador >= 2 then #mas de dos actividades
                    redirect_to home_path, alert: 'El máximo de reservaciones permitidas por semana son 2.'
            else
                if @activity.state == 0 then # estado de la actividad debe ser disponible
                    if Current.user.level.restriction == 1 && Current.user.level.restriction_count > 0  #validar la restricciones del usuario
                        dia_calen = @activity.calendar.day
                        mes_calen = @activity.calendar.month
                        ano_calen = @activity.calendar.year
                        fecha_act = (dia_calen.to_s + "/" + mes_calen.to_s + "/" + ano_calen.to_s).to_s
                        date_fecha_act = fecha_act.to_date  
                        date_fecha_hoy = (Time.now.strftime("%d-%m-%Y")).to_date 
                        nrodias = (date_fecha_act - date_fecha_hoy).to_i
                        rest = Current.user.level.restriction_count
                        if nrodias > rest
                            redirect_to home_path, alert: 'Actividad no se encuentra disponible para reservar'
                        else
                            @activity.user_id = Current.user.id
                            @activity.state = 1
                            if @activity.save
                                redirect_to home_path, notice: 'Actividad actualizada correctamente'
                            else
                                render :edit, activities: :unprocessable_entity
                            end         
                        end    
                    else    
                        @activity.user_id = Current.user.id
                        @activity.state = 1
                        if @activity.save
                            redirect_to home_path, notice: 'Actividad actualizada correctamente'
                        else
                            render :edit, activities: :unprocessable_entity
                        end         
                    end    
                else
                    redirect_to home_path, alert: 'Actividad no se encuentra disponible para reservar'
                end 
            end   
        else
            redirect_to home_path, alert: 'No es posible hacer la reservación, la fecha esta vencida.' 
        end    
    end    

    def destroy
        @activity = Activity.find(params[:id])
        @activity.destroy
        redirect_to activities_path, notice: 'Actividad borrada correctamente', activity: :see_other
    end    

    private

    def activity_params
        params.require(:activity).permit(:state, :observation, :calendar_id, :square_id, :user_id, :place_id)
    end 

end  
