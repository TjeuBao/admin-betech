class PcsController < ApplicationController
  before_action :set_pc, only: %i[show edit update destroy]
  before_action :set_project_options, only: %i[new edit]
  def index
    @pcs = Pc.all
    @pagy, @pcs = pagy_array(@pcs, items: per_page)
  end

  def show
  end

  def new
    @pc = Pc.new
  end

  def edit; end

  def create
    @pc = Pc.new(pc_params)

    respond_to do |format|
      if @pc.save
        format.html { redirect_to @pc, notice: 'Pc was successfully created.' }
        format.json { render :show, status: :created, location: @pc }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pc.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @pc.update(pc_params)
        format.html { redirect_to @pc, notice: 'Pc was successfully updated.' }
        format.json { render :show, status: :ok, location: @pc }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pc.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @pc.destroy
    respond_to do |format|
      format.html { redirect_to pcs_url, notice: 'Pc was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_pc
    @pc = Pc.find(params[:id])
  end
  
  def set_project_options
    @project_options = Project.pluck(:name, :id)
  end
  
  def pc_params
    params.require(:pc).permit({ project_ids: [] }, :full_name, :company_name, :level, pc_projects_attributes: %i[join_date id])
  end
end
