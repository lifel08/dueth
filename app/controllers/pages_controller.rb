class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :profile]

  def home
    @instruments = Instrument.active
    @disable_avatar = true
  end

  def show
    @instrument_id = params[:id]
    @instrument = Instrument.find(@instrument_id)
  end

  def profile
    @disable_avatar = true
    @instruments = current_user.instruments
    render :profile
  end
end
