class CommentsController < ApplicationController

  before_filter :autorize_user, :only => :create
  before_filter :modify_comments, :except => :create

  def create
    @blog_entry = BlogEntry.find(params[:blog_entry_id])
    @comment = @blog_entry.comments.create(params[:comment])
    @comment.user_id = current_user.id
    @comment.save
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @blog_entry, notice: 'Comment was successfully created.'}
      else
        flash[:error] = @comment.errors.full_messages
        format.html { redirect_to @blog_entry, notice: 'Comment has some errors.'}
      end
    end
  end

  def destroy
    @blog_entry = BlogEntry.find(params[:blog_entry_id])
    @comment = @blog_entry.comments.find(params[:id])
    @comment.destroy
    redirect_to blog_entry_path(@blog_entry)
  end
  def edit
    @comment = Comment.find(params[:id])
  end
  def update
    @comment = Comment.find(params[:id])
    @blog_entry = BlogEntry.find(params[:blog_entry_id])
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @blog_entry, notice: 'Blog entry was successfully updated.' }
        format.json { head :ok }        
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity } 
      end
    end
  end

  protected
  def modify_comments
   @user ||= User.find_by_id(session[:user_id]) if session[:user_id]
   if session[:user_id]
    unless session[:user_id] == Comment.find(params[:id]).user_id or @user.access_level == 100
      redirect_to blog_entry_path(BlogEntry.find(params[:blog_entry_id])), notice: "don't have enough rights"
    end
   else
     redirect_to blog_entry_path(BlogEntry.find(params[:blog_entry_id])), notice: "don't log in"
   end 
  end
end
