class InstrumentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show, :search ]

  def index
    @instruments = Instrument.search_title_and_location(params[:title].to_s+','+params[:location].to_s)
  end

  def search
    @instruments = Instrument.search_title_and_location(params[:title].to_s+','+params[:location].to_s)
    render :index
  end

  def show
    @instrument_id = params[:id]
    @instrument = Instrument.find(@instrument_id)
  end

  def new
    @instrument = Instrument.new
  end

  def create
    @instrument = Instrument.new(instrument_params)
      if @instrument.save
        redirect_to instrument_path(@instrument) # to do: verify path
      else
        render :new
      end
  end

  def update
    @instrument.update(instsrument_params)
    redirect_to root_path(@instrument.id) # to do: verify path
  end

  def destroy
    @instrument.destroy
    redirect_to instrument_path
  end

  def instrument_params
    params.require(:instrument).permit(:title, :subtitle, :location, :latitude, :longitude, :price, :photo, :reviews)
  end

  def find_instrument
    @instrument = Instrument.find(params[:id])
  end
end

