class LocationsController < ApplicationController

  # We created the get_all_busses_from_api and is_nearby? methods in the LocationsHelper Module, so we need to include that module.
  include LocationsHelper

  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    # Marta API address, given here: http://www.itsmarta.com/app-developer-resources.aspx
    bus_api_url = 'http://developer.itsmarta.com/BRDRestService/RestBusRealTimeService/GetAllBus'

    # Get all the busses from the API, buses will be an array of JSON objects.
    @buses = get_all_busses_from_api(bus_api_url)

    # Only keep the busses that are close to our user, select! will loop through each element (a JSON object representing a bus) and modify the buses array to only include buses that return true to the is_nearby? method to the array.
    @buses.select! do |bus|
      # This method determines the distance the bus is from the location the user entered and compares it to an acceptable distance that we expect a bus to be from the user. Only buses that return true from is_nearby? will be stored in the buses array after the select! method finishes.
      is_nearby?(@location, bus)
    end
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.'}
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:street_address, :city, :latitude, :longitude, :acceptable_bus_distance)
    end
end
