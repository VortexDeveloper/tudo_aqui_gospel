class RaterController < ApplicationController
  skip_before_action  :verify_authenticity_token

  def create
    if user_signed_in?
      obj = params[:klass].classify.constantize.find(params[:id]) #who's being rated
      obj.rate params[:score].to_f, params[:comment], current_user, params[:dimension]
      render :json => true
    else
      render :json => false
    end
  end
end
