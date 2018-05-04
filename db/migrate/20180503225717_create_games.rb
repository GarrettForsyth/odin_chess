class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.integer :white_user_id
      t.integer :black_user_id
      t.integer :timecontrol

      t.timestamps
    end
  end
end
