class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy detail]
  before_action :set_technology_options
  def index
    @pagy, @projects = pagy(Project, items: per_page)
  end

  def show
    @pagy, @projects = pagy(Project, items: per_page)
  end

  def new
    @project = Project.new
  end

  def edit; end

  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def detail
    @pagy, @projects = pagy(Project, items: per_page)
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def set_technology_options
    @frontend_options = Tech.where(tech_type: "frontend").pluck(:name, :id)
    @backend_options = Tech.where(tech_type: "backend").pluck(:name, :id)
    @db_options = Tech.where(tech_type: "db").pluck(:name, :id)
  end

  def project_params
    params.require(:project).permit({ tech_ids: [] }, :name, :description, :techstack, :image )
  end
end
