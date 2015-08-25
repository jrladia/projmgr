class AddAllStagesColumn < ActiveRecord::Migration
  def change
    add_column :projects, :allstages, :string
  end
end
