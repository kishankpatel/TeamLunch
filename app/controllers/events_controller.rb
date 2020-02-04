class EventsController < ApplicationController
  before_action :authenticate_user
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.order('created_at DESC')
  end

  def show
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    respond_to do |format|
      if @event.save
        @event.update_attribute :created_by, current_user.id
        format.html { redirect_to @event, success: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, success: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, success: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def finalize_place
    event = Event.find_by_id(params[:id])
    response = event.finalize_place(params[:place_id], current_user)
    flash[response[:type]] = response[:message]
    redirect_to event_path(event)
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:name, :description, :date, place_ids: [])
    end
end
