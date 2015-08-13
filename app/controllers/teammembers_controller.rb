class TeammembersController < ApplicationController
    def index
        @teammembers = Teammember.all
    end
    
    def show
    end
    
    def edit
        @teammember = Teammember.find(params[:id])
    end

    def update
    @teammember = Teammember.find(params[:id])
    
        if @teammember.update_attributes(teammember_params)
            redirect_to(:action => 'index')#, :id => @teammember.id)
        else
            render 'edit'
        end
    end
    
    private
        def teammember_params
            params.require(:teammember).permit(:first_name, :last_name, :img)
        end
end
