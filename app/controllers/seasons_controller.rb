class SeasonsController < ApplicationController

  def join
    current_user.users_seasons.create(season_id: params[:id])
    redirect_to request.referrer
  end

  def show
    @all_seasons_users = Season.find(params[:id]).users
    @all_seasons_groups = Season.find(params[:id]).groups
  end

end
