class AddTimecontrolToSeeks < ActiveRecord::Migration[5.1]
  def change
    add_column :seeks, :timecontrol, :integer
  end
end
