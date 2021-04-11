class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @instruments = Instrument.all
  end

  def show
   @instrument = Instrument.find(params[:id])
   render plain: @instrument.title
  end
end
