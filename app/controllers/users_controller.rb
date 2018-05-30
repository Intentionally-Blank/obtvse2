class UsersController < ApplicationController
  attr_accessor :valid_against

  def index
  end

  def create
    token = TokenValidationService.new(params[:jwt], valid_against)
    if token.valid?
      session[:user] = token.grants[:sub]
      flash[:notice] = "Successfully Logged In"
      redirect_to admin_posts_url
    else
      flash[:error] = "JWT not valid!"
      render action: :index
    end
  end

private

  def valid_against
    @valid_against ||= INFO
  end

end
