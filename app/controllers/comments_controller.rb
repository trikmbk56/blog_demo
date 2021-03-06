class CommentsController < ApplicationController
  before_action :logged_in_user, only: [ :create, :destroy]
  before_action :correct_user, only: :destroy

	def create
    @micropost = Micropost.find(params[:comment][:micropost_id])
  	@comment = @micropost.comments.build(comment_params)
    if @comment.save
      respond_to do |format|
      format.html { redirect_to @micropost }
      format.js
    end
    else
      flash[:alert] = "Cann't create comment"
      redirect_to @micropost
    end
  end

  def destroy
    @micropost = @comment.micropost
    if @comment.destroy
      respond_to do |format|
      format.html { redirect_to @micropost }
      format.js
    end
    else
      flash[:alert] = "Cann't delete this comment"
      redirect_to @micropost
    end 
  end

  def edit
    @comment = Comment.find(params[:id])
    @micropost = @comment.micropost
    @user = @comment.user
  end

  def update
    @comment = Comment.find(params[:id])
    @micropost = @comment.micropost
    if !@comment.update(comment_params)
      flash[:alert] = "Cann't edit comment"
      redirect_to @micropost
    else
      flash[:success] = "Updated comment"
      redirect_to @micropost
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
