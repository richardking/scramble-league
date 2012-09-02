class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :scramble_username, use: :slugged
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :scramble_username, :email, :password, :password_confirmation, :remember_me

  validates_presence_of :scramble_username
  validates :scramble_username, :uniqueness => true
  validates :email, :uniqueness => true

  has_many :users_seasons
  has_many :seasons, :through => :users_seasons
  has_many :users_groups
  has_many :groups, :through => :users_groups

  def add_to_group(group_id)
    UsersSeason.find_or_create_by_user_id_and_season_id(self.id, Group.find(group_id).season.id)
    users_groups.create(group_id: group_id)
  end

  def in_group?(group_id)
    groups.include?(Group.find(group_id))
  end

  def active_group
    groups.find_by_season_id(Season.active.id)
  end

  def total_points(group_id)
    Matchup.find_all_by_user_id_and_group_id(self.id, group_id).sum(&:total_points)
  end

  def possible_points(group_id)
    total_points(group_id) + (rounds_left(group_id) * 5)
  end

  def rounds_left(group_id)
    Matchup.find_all_by_user_id_and_group_id(self.id, group_id).map(&:per_round).flatten.count(nil)
  end

  def active?
    Season.find_by_active(true).users.include?(self)
  end

  def create_matchup(opponent_id, group_id)
    Matchup.create(user_id: self.id, opponent_id: opponent_id, group_id: group_id)
  end

end
