class RedoRolesModels < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.belongs_to :projects, index: true
      t.belongs_to :teammembers, index: true
      t.string :rolename
      t.timestamps null: false
    end
  end
end
