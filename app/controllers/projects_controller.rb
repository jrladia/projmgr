class ProjectsController < ApplicationController
    
    @@stages = 
        {   "Pre-Design" => "#D8140B", 
            "Pre-Design: Feasibility" => "#FC340C",
            "Pre-Design: Building Condition Assessment" => "#FA5619",
            "Pre-Design: Programming" => "#F77925",
            "Design" => "#F49B31",
            "Design: Schematic Design" => "#F7B037",
            "Design: Design Development" => "#FBC43C",
            "Construction Documents" => "#FED942",
            "Construction Documents: Specification" => "#DDD440",
            "Construction Documents: Code / Constructibility Reviews" => "#BCD03E",
            "Tender" => "#9BCB3C",
            "Contract Administration" => "#2B7ED8",
            "Close-Out" => "#6418C6",
            "Close-Out: Commissioning" => "#7D16C7",
            "Close-Out: Warranty" => "#9514C7",
            "Close-Out: Submittals" => "#AE12C8",
            "Close-Out: Deficiencies" => "#C60FC9",
            "Close-Out: Final Progress Claims" => "#DE0DC9",
            "Close-Out: As-Builts" => "#F70BCA",
            "Overall" => "#B2667C",
            "Hours" => "olive",
            "Other" => "#7C2E45"
        }


    def index
        @allprojects = Project.all
        @projects = @allprojects.sort_by {|project| project.projnumber.to_i}
        @sortmethod = params[:order]
        @projectssorted = sort(@projects, @sortmethod)
        @description = params[:desc]
        @description ||= "Project Number – Ascending"
        @stages = @@stages
    end
    
    def test
        index
    end
    
    def sort (projects, sort_order)
        stagesort = []
        case sort_order
            when 'pnum_desc'
                return projects.sort {|a, b| b.projnumber <=> a.projnumber}
            when 'pname_asc'
                return projects.sort {|a, b| a.projname <=> b.projname}
            when 'pname_desc'
                return projects.sort {|a, b| b.projname <=> a.projname}
            when 'pm'
                return projects.sort {|a, b| a.pm <=> b.pm}
            when 'jc'
                return projects.sort {|a, b| a.jc <=> b.jc}
            when 'num_team'
                return projects.sort {|a, b| a.teammembers.length <=> b.teammembers.length}
            when 'stage'
                @@stages.keys.each do |x|
                    projects.each do |p|
                        if p.stage == x
                            stagesort << p
                        end
                    end
                end
                
                return stagesort
            else
                return projects
            end
    end
    
    
    
    def new
        @project = Project.new              #create new project
        @allteammembers = Teammember.all    #list all team members from db
        @teammembers = []                   #array of team members
        @prod=[]                            #array of production team 
        @stages = @@stages.keys
        @allstages = []
        
        #loop through team member objects to get first names of each person
        #store in teammmembers array
    
        @allteammembers.each do |x|
            @teammembers << x.first_name
        end
        
        #sort array alphabetically
        @teammembers.sort!
    end
    
    def create
        @project = Project.new(project_params)  #create new project, with all columns 
        @allteammembers = Teammember.all        #list all team members from db
        @teammembers = @project.teammembers     #initialize association with prod
        @prod=[]
        @stages = @@stages.keys
        @allstages = params[:allstages]
        @stagesstring = ""
        
        @project.bgcolour = getColour(@project)
        @team = @project.prod #applying changes to @team
        @project.update_attribute(:allstages, @allstages)
        
        if @project.save
            
            @pm = findrole(@project, "pm")
            @jc = findrole(@project, "jc")
            @prod = getteam(@project)
            
            @project.bgcolour = getColour(@project)
            @project.allstages = @allstages
            
            unless @pm == @jc || @pm == nil
                @teammembers << @pm
            end
            
            unless @jc == @pm || @jc == nil
                @teammembers << @jc
            end
            
             unless @prod == [] || @prod == ""
                @prod.each do |p|
                    current = Teammember.find_by_first_name(p)
                    if (current != @pm) && (current != @jc)
                        @teammembers << current
                    end
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
        @prod = getteam(@project)
        @stages = @@stages.keys
        
        
        @allteammembers.each do |x|
            @teammembers << x.first_name
        end
        
        @teammembers.sort!

    end
    
    def update
        @project = Project.find(params[:projnumber])
                
        if @project.update_attributes(project_params)
            @project.bgcolour = nil
            @teammembers = @project.teammembers
            @teammembers.clear
            @allstages = @project.allstages
            @allstages = ""
            

            @team = @project.prod #applying changes to @team
            @prod=[] # array for after splitting the names

            @allstages = params[:allstages]
            
            @project.update_attribute(:allstages, @allstages)
            
            #apply pm and jc changes
            @pm = findrole(@project, "pm")
            @jc = findrole(@project, "jc")
            @prod = getteam(@project)
            
            unless @pm == @jc || @pm == nil
                @teammembers << @pm
            end
            
            unless @jc == @pm || @jc == nil
                @teammembers << @jc
            end
            
            unless @prod == [] || @prod == ""
                @prod.each do |p|
                    current = Teammember.find_by_first_name(p)
                    if (current != @pm) && (current != @jc)
                        @teammembers << current
                    end
                end
            end
            
            @project.bgcolour = getColour(@project)
            
            redirect_to(:action => 'show', :projnumber => @project.projnumber)
        else
            render 'edit'
        end
    end
    
    def show
        @project = Project.find_by(projnumber: params[:projnumber])
        @pm = findrole(@project, "pm")
        @jc = findrole(@project, "jc")
        @prod = getteam(@project)
    
        @teammembers = @project.teammembers
    end
    
    def destroy
        @project = Project.find_by(projnumber: params[:projnumber])
        @project.delete
        redirect_to root_url
    end
    
    def findrole(project, role)
        sym = project[role]
        
        if (sym == "") || (sym.nil?)  || (sym == [])
            return nil
        else
            Teammember.find(sym)
        end
    end
    
    def getteam(project)
        team = project.prod
        teamarray = []
            
        unless team == nil || team == ""  
            team.gsub!(/\W/, " ")
            teamarray = team.split(" ")
            return teamarray
        else
            return ""
        end
    end
    
    def getStages(project)
        
        stringstage ||= ""
        stages = []
        stages ||= project.allstages.to_s.split(",")
        
        stages.each do |x|
            stringstage << x
        end
        
        return stringstage
    end
    
    def getColour(project)
        project.update_attribute(:bgcolour, @@stages[project.stage])
    end
    
    private
    
        def project_params
            params.require(:project).permit(:projnumber, :projname, :location, :client, :scope, :status, :stage, :allstages, :pm, :jc, :bgcolour, prod: [])
        end

end
