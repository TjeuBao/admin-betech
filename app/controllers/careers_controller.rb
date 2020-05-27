class CareersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_career, only: %i[show edit update destroy]

  def index
    if params[:search]
      @pagy, @careers = pagy(search, per_page)
    else
      @pagy, @careers = pagy(Career.all.order(created_at: :desc), per_page)
    end
  end

  def search
    Career.where('lower(title) LIKE ?', '%' + params[:search].downcase + '%')
  end

  def new
    @career = Career.new
  end

  def edit; end

  def show; end

  def create
    @career = Career.new(career_params)
    respond_to do |format|
      if @career.save
        format.html { redirect_to @career, notice: 'Career was successfully created.' }
        format.json { render :show, status: :created, location: @career }
      else
        format.html { render :new }
        format.json { render json: @career.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @career.update(career_params)
        format.html { redirect_to @career, notice: 'Career was successfully updated.' }
        format.json { render :show, status: :ok, location: @career }
      else
        format.html { render :edit }
        format.json { render json: @career.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @career.destroy
    respond_to do |format|
      format.html { redirect_to careers_url, notice: 'Career was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def set_career
    @career = Career.find(params[:id])
  end

  def career_params
    params.require(:career).permit(:title, :content, :job_type, :status, :image)
  end
end
