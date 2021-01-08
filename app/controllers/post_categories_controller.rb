# frozen_string_literal: true

class PostCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post_category, only: %i[show edit update destroy]

  def index
    @pagy, @post_categories = pagy(PostCategory, items: per_page)
  end

  def show
    @pagy, @posts = pagy(@post_category.posts, items: per_page)
  end

  def new
    @post_category = PostCategory.new
  end

  def create
    @post_category = PostCategory.new(post_category_params)

    respond_to do |format|
      if @post_category.save
        format.html { redirect_to @post_category, notice: 'Post Category was successfully created.' }
        format.json { render :show, status: :created, location: @post_category }
      else
        format.html { render :new }
        format.json { render json: @post_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @post_category.update(post_category_params)
        format.html { redirect_to @post_category, notice: 'Post Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @post_category }
      else
        format.html { render :edit }
        format.json { render json: @post_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post_category.destroy

    respond_to do |format|
      format.html { redirect_to post_categories_url, notice: 'Post Category was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def set_post_category
    @post_category = PostCategory.friendly.find(params[:id])
  end

  def post_category_params
    params.require(:post_category).permit(:title)
  end
end
