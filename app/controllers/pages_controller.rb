class PagesController < ApplicationController

  def home
    @ads = Ad.all.shuffle
    if user_signed_in?
      @columnist = Columnist.where("user_id = ?", current_user.id).first
      @subscriber = Subscriber.where("user_id = ?", current_user.id).first
    end
    @versicles = Versicle.where("show_day = ?", Date.today)
    @ads_ban = Ad.all.order('created_at DESC limit 2').shuffle
    @ads_body = Ad.all.order('created_at DESC limit 10').shuffle
  end
end
