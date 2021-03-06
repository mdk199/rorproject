class CommentsController < ApplicationController
  layout "main.html.erb"

  load_and_authorize_resource
  
    # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.save
        format.html
        format.json { render json: @comment }
        format.js { render "comments/edit", :layout => false }
      end
    end
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])

    respond_to do |format|
      if @comment.save
        @comment.create_activity :create,:owner =>  @comment.user
        flash.now[:notice] = 'Comment was successfully created.'
        format.html { redirect_to @comment}
        format.json { render json: @comment, status: :created, location: @comment }
        format.js { render "comments/create", :layout => false }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
        format.js do
          render "comments/create", :layout => false
        end
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash.now[:notice] = 'Comment was successfully updated.'
        format.html 
        format.json { head :no_content }
        format.js { render "comments/create", :layout => false }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
        format.js { render "comments/create", :layout => false }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.create_activity :destroy,:owner =>  @comment.user
    @comment.destroy
    flash.now[:notice] = 'Comment was successfully removed.'
    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
      format.js { render "comments/destroy", :layout => false }
    end
  end
end
