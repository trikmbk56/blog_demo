class CommentsController < ApplicationController
  before_action :logged_in_user, only: [ :create, :destroy]
  before_action :correct_user, only: :destroy

	def create
    @micropost = Micropost.find(params[:comment][:micropost_id])
  	@comment = @micropost.comments.build(comment_params)
    if @comment.save
      flash[:success] = "Comment posted"
      redirect_to @micropost
    else
      flash[:alert] = "Comment error"
      redirect_to @micropost
    end
  end

  def destroy
    @micropost = @comment.micropost
    if @comment.destroy
      flash[:success] = "Comment deleted"
      redirect_to @micropost
    else
      flash[:alert] = "Cann't delete this comment"
    end 
  end

  private
  	def comment_params
  		params.require(:comment).permit(:content, :user_id)
  	end

    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
  end
end
