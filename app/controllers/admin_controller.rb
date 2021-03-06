class AdminController < ApplicationController
  before_action :require_login

  layout "admin"

private

  def require_login
    unless session[:user]
      render_unauthorized && return
    end
  end

end
