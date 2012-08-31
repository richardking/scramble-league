class UsersController < ApplicationController
  def show
    @all_users_seasons = current_user.seasons
  end

end
