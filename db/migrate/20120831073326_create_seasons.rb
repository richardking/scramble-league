class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.integer :num
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
