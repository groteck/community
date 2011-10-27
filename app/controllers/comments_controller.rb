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
    @blog_entry = Post.find(params[:post_id])
    @comment = @blog_entry.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@blog_entry)
  end
end
