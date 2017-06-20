class BookmarksController < ApplicationController
  before_action :authenticate_user!, :set_bookmark, only: [:show, :edit, :update, :destroy]

  # GET /bookmarks
  # GET /bookmarks.json
  def index
    @bookmarks = current_user.bookmarks.all
  end

  # GET /bookmarks/1
  # GET /bookmarks/1.json
  def show
  end

  # GET /bookmarks/new
  def new
    @bookmark = current_user.bookmarks.new
  end

  # GET /bookmarks/1/edit
  def edit
  end

  # POST /bookmarks
  # POST /bookmarks.json
  def create
    @bookmark = current_user.bookmarks.new(bookmark_params)

    # Add BD :image_bookmark format last_url.png
    name_image_bookmark = @bookmark.url.split('/').last
    @bookmark.image_bookmark = "#{name_image_bookmark}.png".gsub!(/^\"|\"?$/, '')

    # Add image url in app/assets/images/image_bookmark/
    sm = ScreenshotMachine.new(@bookmark.url)
    # Returns a binary stream of the file
    arr = sm.screenshot
    File.open("app/assets/images/image_bookmark/#{name_image_bookmark}.png", 'wb') { |fp| fp.write(arr) }

    # Add title in DD
    document = Nokogiri::HTML(open(@bookmark.url))
    document.search('title').each do |link|
      @bookmark.title = link.content
    end

    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to :bookmarks, notice: 'Bookmark was successfully created.' }
        format.json { render :show, status: :created, location: @bookmark }
      else
        format.html { render :new }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookmarks/1
  # PATCH/PUT /bookmarks/1.json
  def update
    respond_to do |format|
      if @bookmark.update(bookmark_params)
        format.html { redirect_to @bookmark, notice: 'Bookmark was successfully updated.' }
        format.json { render :show, status: :ok, location: @bookmark }
      else
        format.html { render :edit }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookmarks/1
  # DELETE /bookmarks/1.json
  def destroy
    @bookmark.destroy
    respond_to do |format|
      format.html { redirect_to bookmarks_url, notice: 'Bookmark was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookmark
      @bookmark = Bookmark.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bookmark_params
      params.require(:bookmark).permit( :url, :user_id)
    end
end
