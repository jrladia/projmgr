class Teammember < ActiveRecord::Base
    has_many :roles
    has_many :projects, through: :roles
end
