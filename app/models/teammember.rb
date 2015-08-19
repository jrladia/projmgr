class Teammember < ActiveRecord::Base
    
    has_many :roles
    has_many :projects, -> { order 'projects.projnumber' }, through: :roles  #orders associated projects by project number
end
