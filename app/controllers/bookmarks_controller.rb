class BookmarksController < ApplicationController
  def index
    @bookmarks = current_user.bookmarks
  end

  def create
    @route = Run.find(params[:run_id]).route
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.user = current_user
    @bookmark.route = @route
    @bookmark.save
    if @bookmark.save
      redirect_to run_bookmarks_path, notice: 'Bookmark criado com sucesso.'
    else
      render :new
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:photo)
  end
end
