class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :num
      t.integer :season_id

      t.timestamps
    end
  end
end
