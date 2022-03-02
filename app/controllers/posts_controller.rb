# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]
  before_action :set_post_category_options, only: %i[new create edit update]

  def index
    @pagy, @posts = pagy(extract_post, items: per_page)
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save!
        format.html { redirect_to @post, notice: 'Post was successfully created.'}
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.update(deleted: true)

    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = Post.friendly.find(params[:id])
  end

  def set_post_category_options
    @post_category_options = PostCategory.pluck(:title, :id)
  end

  def post_params
    params.require(:post).permit(:post_category_id, :title, :content, :image,
                                 :source, :post_type, :meta_title,
                                 :meta_keyword, :meta_description)
  end

  def extract_post
    return Post.available.search(params[:search]) if params[:search]

    Post.available.order(id: :desc)
  end
end
