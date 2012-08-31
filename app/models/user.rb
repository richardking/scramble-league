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

  validates_presence_of :first_name, :scramble_username
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

end
