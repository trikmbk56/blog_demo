class CommentsController < ApplicationController
  before_action :logged_in_user, only: [ :create, :destroy]
  before_action :correct_user, only: :destroy

	def create
    @micropost = Micropost.find(params[:comment][:micropost_id])
  	@comment = @micropost.comments.build(comment_params)
    if @comment.save
      redirect_to @micropost
    else
    	flash[:alert] = "You can not comment"
    end
  end

  def destroy
    if @comment.destroy
      redirect_to :back
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
