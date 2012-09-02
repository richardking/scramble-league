class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :matchup_id
      t.integer :user_score
      t.integer :opponent_round_id
      t.integer :num

      t.timestamps
    end
  end
end
