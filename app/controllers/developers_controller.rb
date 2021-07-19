class DevelopersController < ApplicationController
  before_action :set_developer, only: %i[show edit update destroy detail]
  before_action :set_project_options, only: %i[new edit]
  before_action :fetch_current_day_tech, :fetch_current_developer, only: %i[index]
  after_action :set_tech_stack, only: %i[create update]
  def index
    @developers = Developer.all
    fetch_filter_tech_day
    fetch_free_after_x_days
    fetch_filter_tech
    @pagy, @developers = pagy_array(@developers.uniq, items: per_page)
  end

  def show
    @pagy, @developers = pagy(Developer, items: per_page)
  end

  def new
    @project_options = Project.pluck(:name, :id)
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
    @developer.developer_projects.destroy_all
    @developer.developer_teches.destroy_all
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
        @temp += p.teches
      end
      @temp2 += @temp.uniq
      d.teches = @temp2.uniq
    end
  end

  def fetch_current_day_tech
    @cur_day = params[:day] if params[:filter]
    @cur_tech = params[:filter][:tech_ids] if params[:filter]
  end

  def fetch_current_developer
    if params[:filter] && params[:filter][:tech_ids].present?
      @developers_current = Developer.joins(:projects, :teches).not_have_current_project.with_teches(params[:filter][:tech_ids])
    else
      @developers_current = Developer.joins(:projects, :teches).not_have_current_project
    end
  end

  def fetch_filter_tech
    return unless params[:filter] && @cur_day.blank? && @cur_tech.present?

    @developers = Developer.joins(:projects, :teches).with_teches(params[:filter][:tech_ids]).or(@developers_current)
  end

  def fetch_free_after_x_days
    return unless params[:filter] && @cur_day.present? && @cur_tech.blank?

    @developers = Developer.joins(:projects, :teches).free_after_x_days(params[:day].to_d).or(@developers_current)
  end

  def fetch_filter_tech_day
    return unless params[:filter] && @cur_day.present? && @cur_tech.present?

    @developers = Developer.joins(:projects, :teches).free_after_x_days(params[:day].to_d).with_teches(params[:filter][:tech_ids]).or(@developers_current)
  end

  def developer_params
    params.require(:developer).permit({ project_ids: [], tech_ids: [] }, :full_name, :company_name, :belong_team, :level, developer_projects_attributes: %i[current id])
  end
end
