class DevelopersController < ApplicationController
  before_action :set_developer, only: %i[show edit update destroy detail]
  before_action :set_project_options, only: %i[new edit]
  def index
    @pagy, @developers = pagy(Developer, items: per_page)
  end

  def show
    @pagy, @developers = pagy(Developer, items: per_page)
  end

  def new
    @developer = Developer.new
  end

  # def edit
  # end

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

  def developer_params
    params.require(:developer).permit({ project_ids: [] }, :full_name, :company_name, :belong_team, :level)
  end
end
