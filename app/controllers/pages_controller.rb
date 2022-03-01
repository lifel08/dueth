class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :profile, :public_profile, :faq, :about, :site_notice, :data_protection, :cookie_settings]

  def home
    @instruments = Instrument.active
    @disable_avatar = true
  end

  def show
    @instrument_id = params[:id]
    @instrument = Instrument.find(@instrument_id)
  end

  def profile
    add_breadcrumb "Your Profile", :profile_path
    @disable_avatar = true
    @instruments = current_user.instruments
    render :profile
  end

  def public_profile
    @instruments = user.instruments
    add_breadcrumb "Instrument Owner", :public_profile_path
    if is_logged_in?
      return redirect_to url_for(action: :profile)
    end
    @user = user
  end

  def faq
    add_breadcrumb "FAQ", :faq_path
  end

  def about
    add_breadcrumb "About", :about_path
  end

  def site_notice
    add_breadcrumb "Site Notice", :site_notice_path
  end

  def data_protection
    add_breadcrumb "Data Protection", :data_protection_path
  end

  def cookie_settings
    add_breadcrumb "Cookie Settings", :cookie_settings_path
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
