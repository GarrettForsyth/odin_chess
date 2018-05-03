class CreateSeeklists < ActiveRecord::Migration[5.1]
  def change
    create_table :seeklists do |t|

      t.timestamps
    end
  end
end
