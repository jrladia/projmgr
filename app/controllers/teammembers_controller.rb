class TeammembersController < ApplicationController
    def index
        require 'uri'
        require 'cgi'
       
        @teammembers = Teammember.all
        @sortmethod = params[:order]
        @teamsorted = sort(@teammembers, @sortmethod)
        @description = params[:desc]
        @description ||= "Order of Hire"
    end
    
    
    def show
    end
    
    def sort(teammembers, sort_order)
        case sort_order
            when 'fn_asc'
                return teammembers.sort {|a, b| a.first_name <=> b.first_name}
            when 'fn_desc'
                return teammembers.sort {|a, b| b.first_name <=> a.first_name}
            when 'ln_asc'
                return teammembers.sort {|a, b| a.last_name <=> b.last_name}
            when 'ln_desc'
                return teammembers.sort {|a, b| b.last_name <=> a.last_name}
            when 'p_asc'
                return teammembers.sort {|a, b| a.projects.length <=> b.projects.length}
            when 'p_desc'
                return teammembers.sort {|a, b| b.projects.length <=> a.projects.length}
            when 'colour'
                return teammembers.sort {|a, b| b.bgcolour <=> a.bgcolour}
            else
                return teammembers
            end
    end

    def edit
        @teammember = Teammember.find(params[:id])
    end

    def update
    @teammember = Teammember.find(params[:id])
    
        if @teammember.update_attributes(teammember_params)
            redirect_to(:action => 'index')
        else
            render 'edit'
        end
    end
    
    private
        def teammember_params
            params.require(:teammember).permit(:first_name, :last_name, :img, :bgcolour)
        end
end
