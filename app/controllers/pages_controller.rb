class PagesController < ApplicationController

  def home
    @columnists = Columnist.all.shuffle
    @banner_home = Ad.active_banner(home: true).first(5)
    @principal_home = Ad.active_side_banner(home: true).first(2)
    @normal_home =Ad.active_normal(home: true).first(10)
  end

  def subscription
    @user = User.find params[:id]
  end
end
