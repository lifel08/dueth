class ApplicationController < ActionController::Base
  add_breadcrumb "Dashboard", :root_path
  before_action :redirect_if_heroku
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  private

  def redirect_if_heroku
    if request.host == 'dueth.herokuapp.com'
      redirect_to "#{request.protocol}dueth.com#{request.path}", status: 301
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :birthday, :photo, :language])
  end

end
