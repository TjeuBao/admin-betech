class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]
  before_action :set_technology_options
  before_action :fetch_current_type_industry, only: %i[index]
  def index
    @projects = extract_project
    fetch_filter_development
    fetch_filter_industry
    fetch_filter_industry_development
    @pagy, @projects = pagy(@projects, items: per_page)
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

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def set_technology_options
    @frontend_options = Tech.frontend.pluck(:name, :id)
    @backend_options = Tech.backend.pluck(:name, :id)
    @db_options = Tech.db.pluck(:name, :id)
    @client_options = Client.pluck(:name, :id)
  end

  def fetch_current_type_industry
    return unless [params[:development_type] || params[:industry]].present?

    @current_type = params[:development_type]
    @current_industry = params[:industry]
  end

  def fetch_filter_development
    return unless @current_type.present? && @current_industry.blank?

    @projects = Project.filter_development_type(params[:development_type])
  end

  def fetch_filter_industry
    return unless @current_industry.present? && @current_type.blank?

    @projects = Project.filter_industry(params[:industry])
  end

  def fetch_filter_industry_development
    return unless @current_type.present? && @current_industry.present?

    @projects = Project.filter_industry_development_type(params[:industry], params[:development_type])
  end

  def project_params
    params.require(:project).permit({ tech_ids: [] }, :client_id, :name, :description, :deployment, :development_type, :industry, :git_repo, :trello, :website, :image, :start_date, :end_date)
  end

  def extract_project
    return Project.search(params[:search]) if params[:search]

    Project.order(id: :desc)
  end
end
