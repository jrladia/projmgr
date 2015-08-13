class AddNewColumnsToAll < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.string :projnumber
      t.string :projname
      t.string :location
      t.string :client
      t.string :scope
      t.integer :status
      t.string :stage
      t.string :pm
      t.string :jc
      t.array :prod
      t.timestamps null: false
  end
end
