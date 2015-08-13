class RenameRolesColumns < ActiveRecord::Migration
  def change
    rename_column :roles, :projects_id, :project_id
    rename_column :roles, :teammembers_id, :teammember_id
  end
end
