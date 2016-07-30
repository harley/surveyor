class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  GUEST = User.new.tap do
    def role
      "guest"
    end
  end.freeze

  private
  def current_user
    return @current_user if @current_user
    if session[:user_id]
      @current_user = User.find_by_id session[:user_id]
    else
      @current_user = GUEST
    end

  end

  def authenticate_user!
    unless current_user
      render plain: 'Access Denied.', status: 403
    end
  end

  def authorize(controller, action)
    unless current_permission.allow?(controller, action)
      if block_given?
        yield
      else
        redirect_to root_path, alert: "Insufficient Permission."
      end
    end
  end

  def current_permission
    Permission.new(current_user)
  end

end
