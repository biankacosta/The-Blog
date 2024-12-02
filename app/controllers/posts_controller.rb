class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
    @comment = @post.comments.build

    Rails.logger.debug "Comments count: #{@post.comments.count}"
    Rails.logger.debug "Comments: #{@post.comments.to_a}"
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    query = params[:query]
    if query.present?
      sanitized_query = ActiveRecord::Base.sanitize_sql_like(query)
      query_for_ts = sanitized_query.split.map { |word| "#{word}:*" }.join(' | ')
  
      @posts = Post.where(
        "to_tsvector('portuguese', name || ' ' || text) @@ to_tsquery('portuguese', ?)",
        query_for_ts
      ).order(
        Arel.sql("ts_rank(to_tsvector('portuguese', name || ' ' || text), to_tsquery('portuguese', '#{query_for_ts}')) DESC")
      )
    else
      @posts = []
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:name, :title, :text, :thumbnail)
    end
end
