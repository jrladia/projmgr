class AddBelongsToToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :project, :belongs_to, index: true
     add_column :roles, :teammembers, :belongs_to, index: true
  end
end
