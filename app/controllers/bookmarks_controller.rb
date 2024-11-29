class BookmarksController < ApplicationController
  def index
    @bookmarks = current_user.bookmarks
  end

  def create
    @route = Run.find(params[:run_id]).route
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.user = current_user
    @bookmark.route = @route
    if @bookmark.save
      redirect_to bookmarks_path, notice: 'Bookmark criado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def bookmark_params
    params.fetch(:bookmark, {}).permit(:photo)
  end
end
