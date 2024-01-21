class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
    raise
  end

  # def destroy
  #   raise
  # end
  private

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :content)
  end
end
