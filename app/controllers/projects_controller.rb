class ProjectsController < ApplicationController
    
    def index
        @projects = Project.all
    end
    
    def new
        @project = Project.new
    end
    
    def create
        @project = Project.new(project_params)
        if @project.save
            redirect_to '/projects'
        else
            render 'new'
        end
    end
    
    def show
    end
    
    private
    
        def project_params
            params.require(:project).permit(:projnumber, :projname, :location, :client, :scope, :status, :stage)
        end

end
