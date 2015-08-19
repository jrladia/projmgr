class AddColourToTeammembers < ActiveRecord::Migration
  def change
    add_column :teammembers, :bgcolour, :string
  end
end
