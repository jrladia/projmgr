class Project < ActiveRecord::Base
    
    has_many :roles
    has_many :teammembers, through: :roles
   
    validates :projnumber, presence: true, :length => { :minimum => 3, :maximum => 4, :message => "must be three digits long."}
    validates :projnumber, uniqueness: true
    validates :projname, presence: true
    validates :client, presence: true
    validates :location, presence: true
    validates :scope, presence: true
    validates :status, presence: true, numericality: { only_integer: true, :greater_than => -1, :less_than_or_equal_to => 100 }, length: { minimum: 1, maximum: 3 }
    validates :stage, presence: true


   
end
