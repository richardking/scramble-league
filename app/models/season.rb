class Season < ActiveRecord::Base
  has_many :users_seasons
  has_many :users, :through => :users_seasons
  has_many :groups, :dependent => :destroy

  def join
    current_user.users_seasons.create(params[:id])
    redirect_to request.referrer
  end

end
