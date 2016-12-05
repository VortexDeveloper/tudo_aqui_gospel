class PagesController < ApplicationController

  def home
    @ads = Ad.all
    if user_signed_in?
      @columnist = Columnist.where("user_id = ?", current_user.id).first
      @subscriber = Subscriber.where("user_id = ?", current_user.id).first
    end
    @versicles = Versicle.where("show_day = ?", Date.today)
  end

end
