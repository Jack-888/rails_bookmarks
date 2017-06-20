class Bookmark < ActiveRecord::Base
  belongs_to :user

  # user id should exist
  validates :user_id, presence: true

  # title should exist and must be 5 chars long
  validates :title, length: { minimum: 5 }, presence: true

  # url must exist and should be properly formed
  validates :url, format: {with: Regexp.new(URI::regexp(%w(http https)))}, presence: true

  # description must exist, should be at least 20 characters long
  # validates :description, length: { minimum: 20 }, presence: true

end
