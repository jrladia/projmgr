class Role < ActiveRecord::Base

    belongs_to :projects
    belongs_to :team_member

end
