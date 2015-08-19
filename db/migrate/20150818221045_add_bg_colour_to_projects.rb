class AddBgColourToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :bgcolour, :string
  end
end
