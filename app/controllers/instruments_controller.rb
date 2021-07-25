class InstrumentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show, :search ]
  before_action :redirect_to_search, only: [:index]
  before_action :find_instrument, only: [:show, :edit, :update, :destroy, :pause, :activate]

  def index
    @instruments = Instrument.active.search_title_and_location(params[:title].to_s+','+params[:city].to_s)
  end

  def search
    @center = Geocoder.search(params[:city]).first.data["center"]

    @instruments = Instrument.active.search_title_and_location(params[:title].to_s+','+params[:city].to_s)
    if @instruments.present?
      render :index
    else
      flash[:notice] = "Not found"
      redirect_to root_path
    end
  end

  def pause
    @instrument.pause!
    redirect_to profile_path, notice: 'Instrument succesfully paused!'
  end

  def activate
    @instrument.activate!
    redirect_to profile_path, notice: 'Instrument succesfully activated!'
  end

  def show
  end

  def edit
    # @instrument.disponibilities.build
  end

  def new
    @instrument = Instrument.new
  end

  def create
    @instrument = current_user.instruments.new(instrument_params)

    if @instrument.save
      redirect_to profile_path
    else
      render :new
    end
  end

  def update
    if @instrument.update(instrument_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  def destroy
    @instrument.destroy
    redirect_to profile_path
  end

  private

  def redirect_to_search
    if (params[:title] || params[:city]).present?
      return redirect_to search_instruments_path(title: params[:title].downcase,
                                                 city: params[:city].downcase), status: 301
    elsif (params[:title] || params[:city]).blank?
      return redirect_to root_path, status: 301
    end
  end

  def instrument_params
    params.require(:instrument).permit(:title, :subtitle, :description,
                                       :street_name, :house_number, :postal_code, :city, :country, :cancellation_policy_id,
                                       :price, :reviews, :photo, :location, feature_ids: [],
                                       disponibilities_attributes: [:id, :from, :to, :_destroy])
  end

  def find_instrument
    @instrument = Instrument.find(params[:id])
  end
end
