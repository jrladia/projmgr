class CreateTeammembers < ActiveRecord::Migration
  def change
    create_table :teammembers do |t|

      t.timestamps null: false
    end
  end
end
