class Project < ActiveRecord::Base
    
    has_many :roles
    has_many :team_members, through: :roles
    
end
