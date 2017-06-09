class PagesController < ApplicationController

  def home
    # User.with_role "Columnist" <-TENTE ISSO
    @columnists = Columnist.activated.shuffle
    @banner_home = Ad.active_banner(home: true).first(5)
    @principal_home = Ad.active_side_banner(home: true).first(2)
    @normal_home =Ad.active_normal(home: true).first(10)
  end

  def subscription
    @user = User.find params[:id]
  end

  def search
    @ads = Ad.joins(announcer: [user: :profile])
    .where("text_description LIKE :query", query: "%#{params[:query]}%")

    respond_to do |format|
      format.html { render :show }
      format.json { render :show, status: :ok, location: @ad }
    end
  end

end
