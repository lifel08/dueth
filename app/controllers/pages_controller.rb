class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :profile, :public_profile]

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

  def public_profile
    if is_logged_in?
      return redirect_to url_for(action: :profile)
    end

    @user = user

  end

  private

  def is_logged_in?
    user == current_user
  end

  def user
    # memoise : remember the user ||=
      @user ||= User.find(params[:id])
  end
end
