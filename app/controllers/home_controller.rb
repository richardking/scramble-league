class HomeController < ApplicationController

  def index
    if user_signed_in? && current_user.active?
      redirect_to season_group_path(Season.active, number: current_user.active_group.num)
    elsif user_signed_in?
      redirect_to user_path(current_user)
    end
  end
end
