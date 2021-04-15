class ApplicationController < ActionController::Base
  before_action :redirect_if_heroku
  before_action :authenticate_user!

  private

  def redirect_if_heroku
    if request.host == 'dueth.herokuapp.com'
      redirect_to "#{request.protocol}dueth.com#{request.path}", status: 301
    end
  end

end
