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

  def vote
    Vote.create(place_id: params[:id], event_id: params[:event_id], voter_id: current_user.id)
    redirect_to request.referrer
  end

  private
  def place_params
    params.require(:place).permit(:name, :address, :created_by)
  end
end
