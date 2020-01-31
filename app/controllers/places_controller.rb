class PlacesController < ApplicationController
  before_action :authenticate_user
  def index
    @places = Place.all.order("created_at DESC")  
  end
  def new
    
  end
  def create
    params[:place][:created_by] = current_user.id
    place = Place.new(place_params)
    respond_to do |format|
      if place.save
        place.update_attribute :is_active, true if current_user.manager?
        begin
          manager = User.where("manager_id is NULL").first
          NotificationMailer.new_place_info_to_manager(place, manager, current_user).deliver
          flash[:success] = "#{place.name} has been created successfully."
        rescue Exception => e
          flash[:danger] = e.message
        end
          format.html { redirect_to places_path }
          format.json { render text: "success", status: :created }
      else
        format.html { render :new }
        format.json { render json: place.errors, status: :unprocessable_entity}
      end
    end
  end

  def approve
    place = Place.find_by_id(params[:id])
    place.update_attributes(is_active: true)
    redirect_to places_path
  end

  def finalize
    place = Place.find_by_id(params[:id])
    if place && current_user.is_manager?
      place.update_attributes(is_finalize: true, finalize_by: current_user.id)
      begin
        users = User.active_users
        NotificationMailer.finalize_place_info_to_users(place, current_user, users).deliver
        flash[:success] = "#{place.name} has been finalised for team lunch."
      rescue Exception => e
        flash[:danger] = e.message
      end
    end
    redirect_to places_path
  end

  private
  def place_params
    params.require(:place).permit(:name, :address, :created_by)
  end
end
