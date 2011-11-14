class CommentsController < ApplicationController
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
end
