class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    else
      @feed_items = Micropost.all.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def post
    @feed_items = Micropost.all.paginate(page: params[:page])
  end
end
