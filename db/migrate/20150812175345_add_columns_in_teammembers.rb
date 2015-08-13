class AddColumnsInTeammembers < ActiveRecord::Migration
  def change
    add_column :teammembers, :first_name, :string
    add_column :teammembers, :last_name, :string
    add_column :teammembers, :img, :string
  end
end
