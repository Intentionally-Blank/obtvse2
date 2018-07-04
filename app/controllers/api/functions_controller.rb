class Api::FunctionsController < ApplicationController
  include ApplicationHelper

  skip_before_action :verify_authenticity_token

  def markdown_preview
    render plain: markdown(params[:content]), layout: false
  end

  def slugify
    render plain: params[:content].to_url, layout: false
  end
end
