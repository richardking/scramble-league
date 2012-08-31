class CreateUsersSeasons < ActiveRecord::Migration
  def change
    create_table :users_seasons do |t|
      t.integer :user_id
      t.integer :season_id

      t.timestamps
    end
  end
end
