class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.all
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.user = current_user
    @bookmark.save

  if @bookmark.save
    redirect_to bookmarks_path, notice: 'Bookmark criado com sucesso.'
  else
    render :new
  end
end

private

def bookmark_params
  params.require(:bookmark).permit(:title, :url)
end
end
