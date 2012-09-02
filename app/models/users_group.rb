class UsersGroup < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  def total_points
    Matchup.find_all_by_user_id_and_group_id(self.user_id, self.group_id).sum(&:total_points)
  end
end
