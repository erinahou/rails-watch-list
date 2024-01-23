class BookmarksController < ApplicationController
  before_action :set_list, only: %i[new]

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    # List can only be found through the url hence the params
    # Replace @bookmark.list_id = nil with the @list_id
    @list = List.find(params[:list_id])
    @bookmark.list_id = @list.id
    # movie_id is in the params
    # Replace @bookmark.movie_id with @movie.id
    @movie = Movie.find(params[:bookmark][:movie_id])
    @bookmark.movie_id = @movie.id
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    # @bookmark = @list.bookmarks.find(params[:id])
    # raise
    # @bookmark.destroy
    redirect_to list_path(@list), status: :see_other
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:movie, :comment)
  end
end
