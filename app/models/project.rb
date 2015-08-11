class Project < ActiveRecord::Base
    
    has_many :roles
    has_many :team_members, through: :roles
   
    validates :projnumber, :presence => {:message => "Project Number can't be blank."}
    validates :projnumber, :length => { :minimum => 3, :maximum => 3, :message => "Project Number must be three digits long."}
    validates :projnumber, :numericality => { :message => "Project Number must be a number."}
    validates :projname, presence: true
    validates :client, presence: true
    validates :location, presence: true
    validates :scope, presence: true
    validates :status, presence: true, numericality: { only_integer: true }, length: { minimum: 1, maximum: 3 }
    validates :stage, presence: true
    

   
end
