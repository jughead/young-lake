class EventsController < ApplicationController
  load_and_authorize_resource

  # GET /events
  # GET /events.json
  def index
    @filterrific = initialize_filterrific(
      Event,
      filter_params,
      select_options: {
        with_city_id: City.all,
        with_theme_id: Theme.all,
      }
    ) or return
    @events = @filterrific.find.includes(:city, :user, :themes).page(params[:page]).per_page(10)
    respond_to do |format|
      format.js {}
      format.html {}
    end
  end

  def store_filter
    @event_filter = current_user.event_filter
    @event_filter.clear_filter_attributes
    @event_filter.attributes = filter_params
    @event_filter.save
    respond_to do |format|
      format.json {}
    end
  end

  def use_stored_filter
    @event_filter = current_user.event_filter
    redirect_to action: :index, event_filter: @event_filter.to_filterrific_params
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    respond_to do |format|
      if @event.save
        NewEventJob.perform_later(@event)
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        NewEventJob.perform_later(@event)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def event_params
      params.require(:event).permit(:title, :description, :city_id, :start_at, :finish_at, theme_ids: [])
    end

    def filter_params
      params.require(:event_filter).permit(
        :reset_filterrific,
        :with_city_id, :with_theme_id, with_start_at_between: [:from, :to]) if params[:event_filter]
    end
end
