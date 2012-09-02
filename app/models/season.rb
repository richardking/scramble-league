class Season < ActiveRecord::Base
  has_many :users_seasons
  has_many :users, :through => :users_seasons
  has_many :groups, :dependent => :destroy

  attr_accessible :start_date, :end_date, :active, :num

  validates_presence_of :start_date, :end_date, :num

  before_save :check_active, only: [:activate]

  def join
    current_user.users_seasons.create(params[:id])
    redirect_to request.referrer
  end

  def activate
    self.update_attribute(:active, true)
  end

  def self.active
    Season.find_by_active(true)
  end

  def begin_season
    groups.each do |g|
      unless g.users.empty?
        g.users.each do |u|
          puts u.id
          g.users.each do |opp|
            puts opp.id
            matchup = u.create_matchup(opp.id, g.id) unless u.id == opp.id
          end
        end
      end
      g.matchups.each do |m|
        m.create_rounds(2)
      end
    end
    activate
  end

  protected

  def check_active
    if active = Season.find_by_active(true)
      active.update_column(:active, false)
    end
  end

end
