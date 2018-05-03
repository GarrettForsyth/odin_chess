class CreateSeeks < ActiveRecord::Migration[5.1]
  def change
    create_table :seeks do |t|
      t.references :user, foreign_key: true
      t.references :seeklist, foreign_key: true

      t.timestamps
    end
  end
end
