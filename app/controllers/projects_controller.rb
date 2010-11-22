class ProjectsController < ApplicationController
  before_filter :login_required, :except => :index
  
  def index
    if params[:category]
      @projects = Project.paginate :page => params[:page], :order => 'created_at DESC', :conditions => ['category_id = ?', params[:category]]
      @filtered = true
    else
      @projects = Project.paginate :page => params[:page], :order => 'created_at DESC'
    end
  end
  
  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(params[:project])
    if not @project.save
      render :text => "Error Saving Project!"
    else
      redirect_to projects_path
    end
  end

  def update
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      redirect_to projects_path
    else
      redirect_to projects_path
    end
  end

end
