class ProjectsController < ApplicationController
    
    def index
        @allprojects = Project.all
        @projects = @allprojects.sort_by {|project| project.projnumber.to_i}
       
    end
    
    
    def new
        @project = Project.new
        @allteammembers = Teammember.all
        @teammembers = []
        @prod=[]
        
        @allteammembers.each do |x|
            @teammembers << x.first_name
        end
        
        @teammembers.sort!
    end
    
    def create
        @project = Project.new(project_params)
        @allteammembers = Teammember.all
        @teammembers = @project.teammembers
        @prod=[]
        
        
        if @project.save
            
            @pm ||= Teammember.find(@project.pm)
            @jc ||= Teammember.find(@project.jc)
        
            @team ||= @project.prod
            @team.gsub!(/\W/, " ")
            @prod = @team.split(" ")
            
            @teammembers << @pm
            
            unless @jc == @pm
                @teammembers << @jc
            end
            
            @prod.each do |p|
                current = Teammember.find_by_first_name(p)
                if (current != @pm) && (current != @jc)
                    @teammembers << current
                end
            end
        
            redirect_to root_path
        else
            render 'new'
        end
    end
    
    def edit
        @project = Project.find_by(projnumber: params[:projnumber])
        @allteammembers = Teammember.all
        @teammembers = []
        @team = @project.prod
        
        @team.gsub!(/\W/, " ")
        @prod = @team.split(" ")
        
        @allteammembers.each do |x|
            @teammembers << x.first_name
        end
        
        @teammembers.sort!

    end
    
    def update
        @project = Project.find(params[:projnumber])
        
        if @project.update_attributes(project_params)
            
            @teammembers = @project.teammembers
            @teammembers.clear

            @team = @project.prod #applying changes to @team
            @prod=[] # array for after splitting the names
            
            #apply pm and jc changes
            @pm = Teammember.find_by_id(@project.pm) #reapplying pm
            @jc = Teammember.find_by_id(@project.jc) #reapplying jc
            @teammembers << @pm
            @teammembers << @jc
            
            
            @team.gsub!(/\W/, " ") 
            @prod = @team.split(" ")
            
            @prod.each do |p|
                current = Teammember.find_by_first_name(p)
                if (current != @pm) && (current != @jc)
                    @teammembers << current
                end
            end
        
            redirect_to(:action => 'show', :projnumber => @project.projnumber)
        else
            render 'edit'
        end
    end
    
    def show
        @project = Project.find_by(projnumber: params[:projnumber])
        @pm = Teammember.find(@project.pm)
        @jc = Teammember.find(@project.jc)
        @team = @project.prod
        @team.gsub!(/\W/, " ") 
        @prod = @team.split(" ")
    
        @teammembers = @project.teammembers
    end
    
    def destroy
        @project = Project.find_by(projnumber: params[:projnumber])
        @project.delete
        redirect_to root_url
    end
    
    private
    
        def project_params
            params.require(:project).permit(:projnumber, :projname, :location, :client, :scope, :status, :stage, :pm, :jc, prod: [])
        end

end
