class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @instruments = Instrument.all
  end

  def show
    @instrument_id = params[:id]
    @instrument = Instrument.find(@instrument_id)
  end
end
