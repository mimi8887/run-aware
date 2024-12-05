class BookmarksController < ApplicationController
  def index
    @bookmarks = current_user.bookmarks
    
  end

  def create
    @route = Run.find(params[:run_id]).route
    @bookmark = Bookmark.find_by(user: current_user, route: @route)
    if @bookmark.nil?
      @bookmark = Bookmark.new(bookmark_params)
      @bookmark.user = current_user
      @bookmark.route = @route
             if @bookmark.save
          redirect_to bookmarks_path, notice: 'Bookmark created successfuly.'
        else
          render :new, status: :unprocessable_entity

      end
    else
      if params[:bookmark][:photos].present?
        @bookmark.photos.attach(params[:bookmark][:photos])
        redirect_to bookmarks_path, notice: 'Photo attached to existing bookmark.'
      end
    end
  end

  def update
    @route = Run.find(params[:run_id]).route
    @bookmark = Bookmark.find(params[:id])
    @bookmark.update!(bookmark_params)
    if params[:bookmark][:photos].present?
      @bookmark.photos.attach(params[:bookmark][:photos])
    end
    redirect_to bookmarks_path
  end

  private

  def bookmark_params
    params.fetch(:bookmark, {}).permit(:comment, photos: [])
  end
end
