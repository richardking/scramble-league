class Round < ActiveRecord::Base
  belongs_to :matchup

  attr_accessible :user_score, :matchup_id, :opponent_round_id, :num
end
