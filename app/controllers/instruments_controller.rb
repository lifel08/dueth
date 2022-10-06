class InstrumentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :search]
  before_action :redirect_to_search, only: [:index]
  before_action :find_instrument, only: [:show, :edit, :update, :destroy, :pause, :activate, :book, :favorite]

  def index
    @instruments = Instrument.active.search_title_and_location(params[:title].to_s + ',' + params[:city].to_s)
  end

  def search
    add_breadcrumb "#{params[:title].capitalize}'s to rent in #{params[:city].capitalize}", :search_instruments_path
    @center = Geocoder.search(params[:city]).first.data["center"]
    @instruments = Instrument.active.search_title_and_location(params[:title].to_s + ',' + params[:city].to_s)
    @features = @instruments.includes(:features).pluck(:name).uniq
    if params[:feature].present?
      @instruments = @instruments.joins(:features).where(features: {name: params[:feature]})
    end
    if params[:price] == '0,15' || params[:price] == '15,40'
      price = params[:price].split(',').map(&:to_i)
      @instruments = @instruments.where('price BETWEEN ? AND ?', price[0], price[1])
    else
      params[:price] == '45'
      @instruments = @instruments.where('price >= ?', params[:price].to_i)
    end
    respond_to do |format|
      format.js
      format.html {render :index}
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
    add_breadcrumb "#{@instrument.title} from #{@instrument.user.first_name }", :instrument_path, only: :show
    @bookings = @instrument.bookings
    if @instrument.reviews.blank?
      @average_review = 0
    else
      @average_review = @instrument.reviews.average(:rating)
    end
  end



  def favorite_list
    add_breadcrumb "My Favorite Instruments", :favorite_list_instruments_path
    @instruments = current_user.favorites
  end

  def new
    add_breadcrumb "My Profile", :profile_path
    add_breadcrumb "New Instrument", :new_instrument_path
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

  def edit
    add_breadcrumb "My Profile", :profile_path
    add_breadcrumb "Edit Instrument", :edit_instrument_path
    # @instrument.disponibilities.build
  end

  def update
    if @instrument.update(instrument_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  def destroy
    @booking = @instrument.bookings
    BookingMailer.decline_booking(@booking).deliver_now if @booking.present?
    @instrument.destroy
    redirect_to profile_path
  end


  def favorite
    if current_user.present?
      type = params[:type]
      case type
      when "favourite"
        current_user.favorites << @instrument
        redirect_back fallback_location: root_path, notice: 'Liked!'
      when "unfavourite"
        current_user.favorites.delete(@instrument)
        redirect_back fallback_location: root_path, notice: 'Unliked!.'
      else
        redirect_back fallback_location: root_path, notice: 'Nothing happened.'
      end
    end
  end


  def get_search_instrument
    if params[:day].present?
      day = params[:day].titleize
      @instruments = Instrument.joins(:availabilities).where("availabilities.day = ? AND availabilities.available = ?", day, true)
    else
      @instruments = Instrument.all
    end
    respond_to do |format|
      format.js {render "index.js.erb"}
    end
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
    params.require(:instrument).permit(:title, :day, :subtitle, :description,
                                       :street_name, :house_number, :postal_code, :city, :country, :cancellation_policy_id,
                                       :price, :reviews, :location, feature_ids: [], photo: [],
                                       availabilities_attributes: [:id, :start_datetime, :end_datetime, :_destroy])
  end

  def find_instrument
    @instrument = Instrument.find(params[:id])
  end
end
