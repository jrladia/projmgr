class ProjectsController < ApplicationController
    
    def index
        @allprojects = Project.all
        @projects = @allprojects.sort_by {|project| project.projnumber.to_i}
    end
    
    def new
        @project = Project.new
    end
    
    def create
        @project = Project.new(project_params)
        
        if @project.save
            redirect_to root_path
        else
            render 'new'
        end
        

    end
    
    def edit
        @project = Project.find_by(projnumber: params[:projnumber])
    end
    
    def update
        @project = Project.find(params[:projnumber])
        if @project.update_attributes(project_params)
            redirect_to(:action => 'show', :projnumber => @project.projnumber)
        else
            render 'edit'
        end
    end
    
    def show
        @project = Project.find_by(projnumber: params[:projnumber])
    end
    
    def destroy
        @project = Project.find_by(projnumber: params[:projnumber])
        @project.delete
        redirect_to root_url
    end
    
    private
    
        def project_params
            params.require(:project).permit(:projnumber, :projname, :location, :client, :scope, :status, :stage)
        end

end
