class Group < ActiveRecord::Base
  attr_accessible :num, :season_id

  belongs_to :season
  has_many :users_groups
  has_many :users, :through => :users_groups
  has_many :matchups

end
