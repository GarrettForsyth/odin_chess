class AddNameToSeeklists < ActiveRecord::Migration[5.1]
  def change
    add_column :seeklists, :name, :string
  end
end
