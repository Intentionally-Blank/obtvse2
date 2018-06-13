class ApplicationController < ActionController::Base
  protect_from_forgery

  prepend_view_path Rails.root.join("frontend")

  def not_found
    logger.error "404 Not Found"
    render template: "errors/404", status: :not_found
  end

  def render_unauthorized
    render plain: "Unauthorized", status: :unauthorized
  end

end
