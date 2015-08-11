class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :projnumber
      t.string :projname
      t.string :location
      t.string :client
      t.string :scope
      t.integer :status
      t.string :stage
      t.timestamps null: false
    end
  end
end
