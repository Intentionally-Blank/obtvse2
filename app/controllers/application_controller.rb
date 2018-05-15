class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :logged_in?
  helper_method :no_users?

  def logged_in?
    !!session[:user]
  end

  def no_users?
    false
  end

  def not_found
    logger.error "404 Not Found"
    render template: "errors/404", status: :not_found
  end

  def render_not_found(exception)
    logger.error "404 Not Found"
    logger.error exception
    render template: "errors/404", status: 404 unless @not_found
  end

  def render_error(exception)
    logger.error "500 Internal Server Error"
    logger.error exception
    render template: "errors/500", status: 500 unless @not_found
  end

  def render_unauthorized
    render plain: "Unauthorized", status: :unauthorized
  end

end
