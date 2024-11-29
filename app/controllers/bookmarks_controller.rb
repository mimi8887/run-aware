class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.all
    @markers = [
      { lat: 52.48773804724966, lng: 13.383683784580231 },
      { lat: 52.486351472937, lng: 13.389951169490814 },
      { lat: 52.481837907201206, lng: 13.395120670145922 },
      { lat: 52.47744842474273, lng: 13.400204121177599 },
      { lat: 52.47180112114213, lng: 13.399752206313258 },
      { lat: 52.46844896928392, lng: 13.394121190369173 },
      { lat: 52.47068324803367, lng: 13.387429690144542 },
      { lat: 52.47542334706799, lng: 13.380502925276214 },
      { lat: 52.48280001108698, lng: 13.379095245741312 },
      { lat: 52.48773804724966, lng: 13.383683784580231 }
      ]
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.user = current_user
    @bookmark.save

  if @bookmark.save
    redirect_to bookmarks_path
    render :new
  end
end

private

def bookmark_params
  params.require(:bookmark).permit(:title, :url)
end
end
