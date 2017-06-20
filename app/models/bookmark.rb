class Bookmark < ActiveRecord::Base
  attr_accessor :url, :image_bookmarks, :title, :description
  belongs_to :user
end
