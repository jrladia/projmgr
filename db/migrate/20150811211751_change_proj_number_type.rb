class ChangeProjNumberType < ActiveRecord::Migration
  def self.up
    change_column :projects, :projnumber, :string
  end
  
  def self.down
    change_column :projects, :projnumber, :integer
  end
end
