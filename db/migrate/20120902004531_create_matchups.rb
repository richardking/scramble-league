class CreateMatchups < ActiveRecord::Migration
  def change
    create_table :matchups do |t|
      t.integer :user_id
      t.integer :opponent_id
      t.integer :group_id

      t.timestamps
    end
  end
end
