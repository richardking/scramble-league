class MatchupsController < ApplicationController

  def update
    Rails.logger.debug "test"
    params[:matchup][:round].each do |key, value|
      unless value[:user_score].empty?
        round = Round.find(key.to_i)
        round.update_attribute(:user_score, value[:user_score].to_i)
        Round.find(round.opponent_round_id).update_attribute(:user_score, (5-round.user_score))
      end
    end
    redirect_to request.referrer
  end

end
