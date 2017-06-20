class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string   "url"
      t.string   "image_bookmark"
      t.string   "title"
      t.text     "description"
      t.integer  "user_id"

      t.datetime "published_at"
      t.datetime "created_at",         :null => false
      t.datetime "updated_at",         :null => false

      t.timestamps null: false
    end
  end
end
