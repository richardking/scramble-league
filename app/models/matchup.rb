class Matchup < ActiveRecord::Base
  has_many :rounds, :dependent => :destroy
  accepts_nested_attributes_for :rounds
  belongs_to :group

  attr_accessible :rounds_attributes, :user_id, :opponent_id, :group_id

  def opponent_matchup
    Matchup.find_by_user_id_and_opponent_id_and_group_id(opponent_id, user_id, group_id)
  end

  def create_rounds(number)
    Rails.logger.debug "create rounds"
    index = 1
    while rounds.count < number
      round = Round.find_or_create_by_matchup_id_and_num(self.id, index)
      opponent_round = Round.find_or_initialize_by_matchup_id_and_num(opponent_matchup.id, index)
      opponent_round.update_attribute(:opponent_round_id, round.id)
      opponent_round.save
      round.update_attribute(:opponent_round_id, opponent_round.id)
      index += 1
    end
  end

  def total_points
    rounds.map{|r| r.user_score ? r.user_score : 0}.sum
  end

  def per_round
    rounds.map{|r| r.user_score}
  end


  # def check_rounds(number)
  #   Rails.logger.debug "check rounds"
  #   if rounds.count.zero?
  #     create_rounds(number)
  #   end
  # end

end
