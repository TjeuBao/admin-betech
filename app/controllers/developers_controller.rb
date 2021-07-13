class DevelopersController < ApplicationController
  before_action :set_developer, only: %i[show edit update destroy detail]
  before_action :set_project_options
  before_action :set_current_day, only: %i[index]
  before_action :set_current_technology, only: %i[index]
  before_action :fetch_current_developer, only: %i[index]
  after_action :set_tech_stack
  def index
    @pagy, @developers = pagy(Developer.includes(:projects, :teches), items: per_page)
    @developers = Developer.joins(:projects, :teches).filter_day(params[:day].to_d).filter_developer(params[:developer][:tech_id]).or(@developers_current.filter_developer(params[:developer][:tech_id])).uniq if params[:developer] && params[:day] != '' && params[:developer][:tech_id] != ''
    @developers = Developer.joins(:projects, :teches).filter_day(params[:day].to_d).or(@developers_current).uniq if params[:developer] && params[:day] != ''
    @developers = Developer.joins(:projects, :teches).filter_developer(params[:developer][:tech_id]).or(@developers_current.filter_developer(params[:developer][:tech_id])).includes(:projects, :teches).uniq 
    end
  end

  def show
    @pagy, @developers = pagy(Developer, items: per_page)
  end

  def new
    @developer = Developer.new
  end

  def edit; end

  def create
    @developer = Developer.new(developer_params)

    respond_to do |format|
      if @developer.save
        format.html { redirect_to @developer, notice: 'Developer was successfully created.' }
        format.json { render :show, status: :created, location: @developer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @developer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @developer.update(developer_params)
        format.html { redirect_to @developer, notice: 'Developer was successfully updated.' }
        format.json { render :show, status: :ok, location: @developer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @developer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @developer.destroy
    respond_to do |format|
      format.html { redirect_to developers_url, notice: 'Developer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def detail
    @pagy, @developers = pagy(Developer, items: per_page)
  end

  private

  def set_developer
    @developer = Developer.find(params[:id])
  end

  def set_project_options
    @project_options = Project.pluck(:name, :id)
  end

  def set_tech_stack
    @developers = Developer.all
    @developers.each do |d|
      @temp = []
      @temp2 = []
      d.projects.each do |p|
        @temp += p.teches.all
      end
      @temp2 += @temp.uniq
      d.teches = @temp2.uniq
    end
  end

  def set_current_day
    @current_day = params[:day] if params[:developer]
  end

  def set_current_technology
    @current_technology = params[:developer][:tech_id] if params[:developer]
  end

  def fetch_current_developer
    @developers_current = Developer.joins(:projects, :teches).filter_current
  end

  def developer_params
    params.require(:developer).permit({ project_ids: [], tech_ids: [] }, :full_name, :company_name, :belong_team, :level, developer_projects_attributes: %i[current id])
  end
end
