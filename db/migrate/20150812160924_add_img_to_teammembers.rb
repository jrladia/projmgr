class AddImgToTeammembers < ActiveRecord::Migration
  def change
    add_column :team_members, :img, :string
  end
end
