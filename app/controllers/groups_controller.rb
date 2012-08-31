class GroupsController < ApplicationController

  def show
    @current_group = Group.find_by_season_id_and_num(params[:season_id], params[:number])
    @all_group_users = @current_group.users
    @all_opponents = @all_group_users - [current_user]
  end
end
