class TeamMembersController < ApplicationController
    
    def index
        @teammembers = TeamMember.all
    end
end
