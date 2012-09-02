class SeasonsController < ApplicationController

  def join
    current_user.users_seasons.create(season_id: params[:id])
    redirect_to request.referrer
  end

  def unjoin
    UsersSeason.find_by_user_id_and_season_id(current_user.id, params[:id]).destroy
    redirect_to request.referrer
  end

  def show
    @all_seasons_users = Season.find(params[:id]).users
    @all_seasons_groups = Season.find(params[:id]).groups
  end

end
