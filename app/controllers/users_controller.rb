class UsersController < ApplicationController
  def show
    @current_season = Season.active
    @past_seasons = Season.all.select{|s| (s.end_date - Time.now) < 0}
    @future_seasons = Season.all - [@current_season] - @past_seasons
    @all_users_seasons = current_user.seasons
  end

end
