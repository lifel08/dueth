class InstrumentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show, :search ]
  before_action :redirect_to_search, only: [:index]

  def index
    @instruments = Instrument.search_title_and_location(params[:title].to_s+','+params[:location].to_s)
  end

  def search
    @instruments = Instrument.search_title_and_location(params[:title].to_s+','+params[:location].to_s)
    if @instruments.present?
      render :index
    else
      flash[:notice] = "Not found"
      redirect_to root_path
    end
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
      redirect_to profile_path , status: :created
    else
      @instrument.instrument_features.build
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

  private

  def redirect_to_search
    if params[:title] || params[:location]
      return redirect_to search_instruments_path(title: params[:title].downcase, location: params[:location].downcase), status: 301
    end
  end

  def instrument_params
    params.require(:instrument).permit(:title, :subtitle, :description, :location, :latitude, :longitude,
     :price, :photo, :reviews, feature_ids: [])
  end

  def find_instrument
    @instrument = Instrument.find(params[:id])
  end
end

